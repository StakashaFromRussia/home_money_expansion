&После("ОбработкаЗаполнения")
Процедура РЗ_ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Если ДанныеЗаполнения.Свойство("Задача") Тогда
			ЗаполнитьПоЗадаче(ДанныеЗаполнения.Задача);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Процедура ЗаполнитьПоЗадаче(Задача)
	
	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("Пользователь", ПараметрыСеанса.ТекущийПользователь);
	
	СтатьяДохода = Справочники.КошелькиИСчета.НайтиПоНаименованию("Фриланс / подработка");
	ТаблицаАналитики = ПолучитьТаблицуАналитики(СтатьяДохода);
	
	НовыйДоход = Доходы.Добавить();
	НовыйДоход.СтатьяДохода = 
	НовыйДоход.СуммаДохода = ПолучитьСуммуДохода(Задача);
	НовыйДоход.Кошелек = ПолучитьКошелекПоСтатейДохода(ТаблицаАналитики);		
КонецПроцедуры

Функция ПолучитьКошелекПоСтатейДохода(ТаблицаАналитики)
//	ВидАналитики = 
КонецФункции

Функция ПолучитьСуммуДохода(Задача)
	Сумма = 0;
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	РЗ_ЦеныЗанятийСрезПоследних.Цена,
		|	РЗ_ЦеныЗанятийСрезПоследних.УченикГруппа
		|ИЗ
		|	РегистрСведений.РЗ_ЦеныЗанятий.СрезПоследних(, УченикГруппа = &Заказчик) КАК РЗ_ЦеныЗанятийСрезПоследних";
	
	Запрос.УстановитьПараметр("Заказчик", Задача.Заказчик);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Сумма = Задача.КоличествоЧасов * ВыборкаДетальныеЗаписи.Цена;
	КонецЦикла;
	
	Возврат Сумма;
КонецФункции

Функция ПолучитьТаблицуАналитики(Статья)
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Статья", Статья);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НастройкиАналитикиПоСтатьям.ВидАналитики,
	|	НастройкиАналитикиПоСтатьям.ЗначениеПоУмолчанию
	|ИЗ
	|	РегистрСведений.НастройкиАналитикиПоСтатьям КАК НастройкиАналитикиПоСтатьям
	|ГДЕ
	|	НастройкиАналитикиПоСтатьям.Статья = &Статья
	|	И НастройкиАналитикиПоСтатьям.Использовать
	|	И НЕ НастройкиАналитикиПоСтатьям.ВидАналитики.ПометкаУдаления
	|	И НастройкиАналитикиПоСтатьям.ВидАналитики.АктуальнаДляДохода
	|	И НастройкиАналитикиПоСтатьям.ВидАналитики.РасширенныеНастройкиДляДохода
	|
	|УПОРЯДОЧИТЬ ПО
	|	НастройкиАналитикиПоСтатьям.ВидАналитики.Наименование";
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции