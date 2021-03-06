#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Если ДанныеЗаполнения.Свойство("Хронометраж") Тогда
			ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
			Для Каждого СтрокаЗадач Из ДанныеЗаполнения.УчетВремени Цикл
				ЗаполнитьЗначенияСвойств(УчетВремени.Добавить(), СтрокаЗадач);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	МассивНепроверяемыхРеквизитов = Новый Массив;
	Если ВидОперации = ПредопределенноеЗначение("Перечисление.РЗ_ВидыУчетаРабочегоВремени.Языки") Тогда
		МассивНепроверяемыхРеквизитов.Добавить("УчетВремени.Задача");		
	КонецЕсли;
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Ссылка.Дата КАК Период,
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Контакт,
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Задача,
		|	СУММА(РЗ_УчетРабочегоВремениНовыйУчетВремени.КоличествоЧасов) КАК КоличествоЧасов
		|ИЗ
		|	Документ.РЗ_УчетРабочегоВремениНовый.УчетВремени КАК РЗ_УчетРабочегоВремениНовыйУчетВремени
		|ГДЕ
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Ссылка = &Ссылка
		|СГРУППИРОВАТЬ ПО
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Ссылка.Дата,
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Контакт,
		|	РЗ_УчетРабочегоВремениНовыйУчетВремени.Задача";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	// регистр РЗ_УчетРабочегоВремени
	Движения.РЗ_УчетРабочегоВремени.Записывать = Истина;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Движение = Движения.РЗ_УчетРабочегоВремени.Добавить();
		ЗаполнитьЗначенияСвойств(Движение, ВыборкаДетальныеЗаписи);
	КонецЦикла;

	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры

#КонецЕсли