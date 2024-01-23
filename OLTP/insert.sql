INSERT INTO production.categories (category_id, category_name)
VALUES 
    ('CHB1', 'Children Bicycles'),
    ('CMB2', 'Comfort Bicycles'),
    ('CRB3', 'Cruisers Bicycles'),
    ('CYB4', 'Cyclocross Bicycles'),
    ('ELB5', 'Electric Bikes'),
    ('MOB6', 'Mountain Bikes'),
    ('RDB7', 'Road Bike');

INSERT INTO sales.stores (store_id, store_name, phone, email, street, city, state, zip_code)
VALUES 
('ST1', 'Santa Cruz Bikes', '(831) 476-4321', 'santacruz@bikes.shop', '3700 Portola Drive', 'Santa Cruz', 'CA', '95060'),
('ST2', 'Baldwin Bikes', '(516) 379-8888', 'baldwin@bikes.shop', '4200 Chestnut Lane', 'Baldwin', 'NY', '11432'),
('ST3', 'Rowlett Bikes', '(972) 530-5555', 'rowlett@bikes.shop', '8000 Fairway Avenue', 'Rowlett', 'TX', '75088');

INSERT INTO production.brands (brand_id, brand_name)
VALUES 
    ('BRD1', 'Electra'),
    ('BRD2', 'Haro'),
    ('BRD3', 'Heller'),
    ('BRD4', 'Pure Cycles'),
    ('BRD5', 'Ritchey'),
    ('BRD6', 'Strider'),
    ('BRD7', 'Sun Bicycles'),
    ('BRD8', 'Surly'),
    ('BRD9', 'Trek');

INSERT INTO sales.staffs (staff_id, first_name, last_name, email, phone, active, store_id, manager_id)
VALUES
    (3031, 'Fabiola', 'Jackson', 'fabiola.jackson@bikes.shop', '(831) 555-5554', 1, 'ST1', NULL),
    (30310, 'Bernardine', 'Houston', 'bernardine.houston@bikes.shop', '(972) 530-5557', 1, 'ST3', 3037),
    (3032, 'Mireya', 'Copeland', 'mireya.copeland@bikes.shop', '(831) 555-5555', 1, 'ST1', 3031),
    (3033, 'Genna', 'Serrano', 'genna.serrano@bikes.shop', '(831) 555-5556', 1, 'ST1', 3032),
    (3034, 'Virgie', 'Wiggins', 'virgie.wiggins@bikes.shop', '(831) 555-5557', 1, 'ST1', 3032),
    (3035, 'Jannette', 'David', 'jannette.david@bikes.shop', '(516) 379-4444', 1, 'ST2', 3031),
    (3036, 'Marcelene', 'Boyer', 'marcelene.boyer@bikes.shop', '(516) 379-4445', 1, 'ST2', 3035),
    (3037, 'Venita', 'Daniel', 'venita.daniel@bikes.shop', '(516) 379-4446', 1, 'ST2', 3035),
    (3038, 'Kali', 'Vargas', 'kali.vargas@bikes.shop', '(972) 530-5555', 1, 'ST3', 3031),
    (3039, 'Layla', 'Terrell', 'layla.terrell@bikes.shop', '(972) 530-5556', 1, 'ST3', 3037);