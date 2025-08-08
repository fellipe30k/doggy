# config/initializers/date_formats.rb - FORMATOS DE DATA PERSONALIZADOS
Date::DATE_FORMATS[:br] = '%d/%m/%Y'
Date::DATE_FORMATS[:br_short] = '%d/%m'
Date::DATE_FORMATS[:br_long] = '%d de %B de %Y'

Time::DATE_FORMATS[:br] = '%d/%m/%Y %H:%M'
Time::DATE_FORMATS[:br_short] = '%d/%m %H:%M'
Time::DATE_FORMATS[:br_long] = '%d de %B de %Y às %H:%M'