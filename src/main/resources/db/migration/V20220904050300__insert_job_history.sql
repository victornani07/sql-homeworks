INSERT INTO jobs VALUES (
    1,
    'Java Developer',
    9000,
    15000
);

INSERT INTO regions VALUES (
    14,
    'Botanica'
);

INSERT INTO countries VALUES (
    15,
    'Moldova',
    14
);

INSERT INTO locations VALUES (
    13,
    'Sf. Stefan 2',
    'MD-1234',
    'Chisinau',
    'Chisinau',
    15
);

INSERT INTO departments VALUES (
    3,
    'Endava',
    null,
    13
);

INSERT INTO employees VALUES (
    4,
    'Visadctor',
    'Nasdasdni',
    'victasor.nani@endava.com',
    '+373-60-404-117',
    TO_DATE('2021/04/09', 'YYYY/MM/DD'),
    1,
    12000,
    NULL,
    NULL,
    3
);

INSERT INTO job_history VALUES (
    4,
    TO_DATE('2021/04/09', 'YYYY/MM/DD'),
    TO_DATE('2022/03/06', 'YYYY/MM/DD'),
    1,
    3
);