const String addressRegex =
    r'^(г\.?\s?[А-Яа-я]+,\s*)?(ул\.|пр-т|пер\.)\s?[А-Яа-я]+[А-Яа-я\d\s\-]*\s*,\s*\d{1,3}(?:\\\d{1})?$';
const String phoneNumberRegex =
    r'^\+?375\(?([0-9]{2})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{2})[-. ]?([0-9]{2})$';
const String organizationNumberRegex =
    r'^(ОАО|ЗАО|ООО|ИП|ЧУП|КУП|ГУП)\s(([A-Za-z]+)|([А-Яа-я]+))\s*$';
