
// Возвращает представление месяца по переданной дате.
//
// Параметры:
//		ДатаНачалаМесяца
//
// Возвращаемое значение;
//		Строка
//
Функция ПолучитьПредставлениеМесяца(ДатаНачалаМесяца) Экспорт
	
	Возврат Формат(ДатаНачалаМесяца, "ДФ='ММММ гггг'");
	
КонецФункции
