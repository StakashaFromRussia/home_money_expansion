
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустая() Тогда
		Объект.Состояние = Перечисления.РЗ_СостоянияЗадач.Выполняется;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НачатьВыполнение(Команда)
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;
	ПараметрыФормы = Новый Структура("Задача", Объект.Ссылка);
	ОткрытьФорму("РегистрСведений.РЗ_Хронометраж.Форма.ФормаВыполненияЗадачи", ПараметрыФормы, ЭтотОбъект,,,,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ЗакончитьВыполнение(Команда)
	ЗакончитьВыполнениеНаСервере(Объект.Ссылка);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗакончитьВыполнениеНаСервере(Задача)
	РегистрыСведений.РЗ_Хронометраж.ЗавершениеВыполнения(Задача);
КонецПроцедуры // ЗакончитьВыполнениеНаСервере(Задача)
