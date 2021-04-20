
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустая() Тогда
		ПериодСтрокой = ПредставлениеПериода(НачалоМесяца(ТекущаяДатаСеанса()), КонецМесяца(ТекущаяДатаСеанса()));
	Иначе
		ПериодСтрокой = ПредставлениеПериода(НачалоМесяца(Объект.Период), КонецМесяца(Объект.Период));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойПриИзменении(Элемент)
	РЗ_ОбщегоНазначенияКлиент.ВводМесяцаПриИзменении(ЭтаФорма, "Объект.Период", "ПериодСтрокой", Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Оповещение = Новый ОписаниеОповещения("ПериодРегистрацииНачалоВыбораЗавершение", ЭтотОбъект);
	РЗ_ОбщегоНазначенияКлиент.ВводМесяцаНачалоВыбора(ЭтаФорма, ЭтаФорма, "Объект.Период", "ПериодСтрокой", , Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	РЗ_ОбщегоНазначенияКлиент.ВводМесяцаРегулирование(ЭтаФорма, "Объект.Период", "ПериодСтрокой", Направление, Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	РЗ_ОбщегоНазначенияКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПериодСтрокойОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	РЗ_ОбщегоНазначенияКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПериодРегистрацииНачалоВыбораЗавершение(ЗначениеВыбрано, ДополнительныеПараметры) Экспорт
		
КонецПроцедуры
