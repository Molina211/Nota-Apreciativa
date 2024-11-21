DROP DATABASE IF EXISTS Base;
CREATE DATABASE Base;
USE Base;

CREATE TABLE category (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(30),
    name VARCHAR(100),
    description TEXT,
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),      
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE person (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(200),
    document_num VARCHAR(100),
    document_type VARCHAR(100),
    email VARCHAR(100),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    middle_name VARCHAR(100),
    phone VARCHAR(10),
    second_last_name VARCHAR(100),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE payment_method (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(30),
    name VARCHAR(100),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE company (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(200),
    email VARCHAR(100),
    name VARCHAR(100),
    phone VARCHAR(10),
    manager_id BIGINT,
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE branch (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(200),
    email VARCHAR(100),
    name VARCHAR(100),
    phone VARCHAR(10),
    company_id BIGINT,
    responsible_id BIGINT,
    FOREIGN KEY (company_id) REFERENCES company(id),
    FOREIGN KEY (responsible_id) REFERENCES person(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE product (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(100),
    description VARCHAR(100),
    name VARCHAR(100),
    category_id BIGINT,
    FOREIGN KEY (category_id) REFERENCES category(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE inventory (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    purchase_value DOUBLE,
    sale_value DOUBLE,
    stock INT,
    branch_id BIGINT,
    product_id BIGINT,
    FOREIGN KEY (branch_id) REFERENCES branch(id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE invoice (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    discount_value DOUBLE,
    gross_value DOUBLE,
    net_value DOUBLE,
    paym_method_id BIGINT,
    client_id BIGINT,
    FOREIGN KEY (paym_method_id) REFERENCES payment_method(id),
    FOREIGN KEY (client_id) REFERENCES person(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE invoice_detail (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    discount_percentage DOUBLE,
    gross_value DOUBLE,
    net_value DOUBLE,
    quantity INT,
    product_id BIGINT,
    invoice_id BIGINT,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(200),
    username VARCHAR(100),
    person_id BIGINT,
    FOREIGN KEY (person_id) REFERENCES person(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE role (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(100),
    description VARCHAR(200),
    name VARCHAR(100),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE user_role (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    role_id BIGINT,
    user_id BIGINT,
    FOREIGN KEY (role_id) REFERENCES role(id),
    FOREIGN KEY (user_id) REFERENCES user(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE view (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(100),
    description VARCHAR(200),
    name VARCHAR(100),
    path VARCHAR(200),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE module (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(100),
    description VARCHAR(200),
    name VARCHAR(100),
    path VARCHAR(200),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE module_view (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    module_id BIGINT,
    view_id BIGINT,
    FOREIGN KEY (module_id) REFERENCES module(id),
    FOREIGN KEY (view_id) REFERENCES view(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

CREATE TABLE role_module (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    role_id BIGINT,
    module_id BIGINT,
    FOREIGN KEY (role_id) REFERENCES role(id),
    FOREIGN KEY (module_id) REFERENCES module(id),
    created_at DATETIME(6),
    created_by BIGINT,
    deleted_at DATETIME(6),
    deleted_by BIGINT,
    state BIT(1),
    updated_at DATETIME(6),
    updated_by BIGINT
);

/*
INSERT INTO category (code, name, description, state)
VALUES 
('CAT001', 'Electronics', 'Category for electronic products', 1),
('CAT002', 'Furniture', 'Category for furniture items', 1),
('CAT003', 'Clothing', 'Category for clothing and apparel', 1),
('CAT004', 'Toys', 'Category for toys and games', 1),
('CAT005', 'Books', 'Category for all types of books', 1),
('CAT006', 'Kitchen Appliances', 'Category for kitchen appliances', 1),
('CAT007', 'Groceries', 'Category for groceries and food items', 1),
('CAT008', 'Health & Beauty', 'Category for health and beauty products', 1),
('CAT009', 'Sports', 'Category for sports equipment', 1),
('CAT010', 'Automotive', 'Category for automotive products', 1),
('CAT011', 'Home Decor', 'Category for home decor items', 1),
('CAT012', 'Pets', 'Category for pet-related products', 1),
('CAT013', 'Stationery', 'Category for office and school supplies', 1),
('CAT014', 'Footwear', 'Category for shoes and footwear', 1),
('CAT015', 'Jewelry', 'Category for jewelry and accessories', 1),
('CAT016', 'Music', 'Category for music-related items', 1),
('CAT017', 'Movies', 'Category for movies and DVDs', 1),
('CAT018', 'Office Furniture', 'Category for office furniture', 1),
('CAT019', 'Gifts', 'Category for gift items', 1),
('CAT020', 'Gardening', 'Category for gardening tools and accessories', 1);

INSERT INTO person (address, document_num, document_type, email, first_name, last_name, middle_name, phone, second_last_name, state)
VALUES 
('Calle 10 #25-30', '123456789', 'Cédula de Ciudadanía', 'juan.perez@example.com', 'Juan', 'Pérez', 'Carlos', '3012345678', 'Martínez', 1),
('Carrera 50 #13-40', '987654321', 'Cédula de Ciudadanía', 'ana.gomez@example.com', 'Ana', 'Gómez', 'María', '3109876543', 'Rodríguez', 1),
('Avenida 25 #3-15', '456123789', 'Cédula de Ciudadanía', 'luis.sanchez@example.com', 'Luis', 'Sánchez', 'Fernando', '3123456789', 'Hernández', 1),
('Calle 50 #9-20', '321654987', 'Cédula de Ciudadanía', 'maria.lopez@example.com', 'María', 'López', 'Fernanda', '3112345670', 'Martínez', 1),
('Carrera 60 #8-10', '159753456', 'Pasaporte', 'pedro.jimenez@example.com', 'Pedro', 'Jiménez', 'José', '3101234560', 'Paredes', 1),
('Calle 80 #12-15', '321456987', 'Cédula de Ciudadanía', 'laura.martinez@example.com', 'Laura', 'Martínez', 'Esther', '3134567891', 'Mora', 1),
('Avenida 90 #4-30', '654321789', 'Cédula de Ciudadanía', 'josep.alvarez@example.com', 'José', 'Álvarez', 'Antonio', '3156789012', 'Torres', 1),
('Calle 120 #14-25', '789456123', 'Cédula de Ciudadanía', 'carla.ramirez@example.com', 'Carla', 'Ramírez', 'Marta', '3178901233', 'González', 1),
('Carrera 10 #8-45', '951753456', 'Cédula de Ciudadanía', 'juanita.diaz@example.com', 'Juanita', 'Díaz', 'Sofía', '3190123454', 'Santos', 1),
('Avenida 110 #7-80', '357159654', 'Cédula de Ciudadanía', 'roberto.garcia@example.com', 'Roberto', 'García', 'Luis', '3212345675', 'López', 1),
('Calle 130 #5-35', '741852963', 'Pasaporte', 'margarita.castro@example.com', 'Margarita', 'Castro', 'Elena', '3234567896', 'Gómez', 1),
('Carrera 40 #3-10', '258369741', 'Cédula de Ciudadanía', 'roberto.morales@example.com', 'Roberto', 'Morales', 'José', '3256789017', 'Ríos', 1),
('Avenida 70 #9-15', '369258147', 'Cédula de Ciudadanía', 'alicia.mendoza@example.com', 'Alicia', 'Mendoza', 'Luisa', '3278901238', 'Ávila', 1),
('Calle 40 #1-5', '753159456', 'Cédula de Ciudadanía', 'carolina.palacios@example.com', 'Carolina', 'Palacios', 'Raquel', '3290123459', 'Jiménez', 1),
('Carrera 55 #12-50', '951852357', 'Pasaporte', 'felipe.martinez@example.com', 'Felipe', 'Martínez', 'Carlos', '3312345670', 'Ramírez', 1),
('Avenida 10 #7-50', '159753258', 'Cédula de Ciudadanía', 'sofia.lopez@example.com', 'Sofía', 'López', 'Patricia', '3334567891', 'Ortiz', 1),
('Calle 15 #8-35', '852963741', 'Cédula de Ciudadanía', 'carlos.garcia@example.com', 'Carlos', 'García', 'Antonio', '3356789012', 'Torres', 1),
('Carrera 20 #3-20', '963852741', 'Cédula de Ciudadanía', 'marta.sanchez@example.com', 'Marta', 'Sánchez', 'Celia', '3378901233', 'Martínez', 1),
('Avenida 80 #12-90', '123987654', 'Cédula de Ciudadanía', 'jorge.martinez@example.com', 'Jorge', 'Martínez', 'Eduardo', '3390123454', 'Santos', 1),
('Calle 50 #11-80', '321654987', 'Pasaporte', 'diana.flores@example.com', 'Diana', 'Flores', 'Claudia', '3412345675', 'Ramírez', 1),
('Carrera 30 #6-30', '258963147', 'Cédula de Ciudadanía', 'manuel.hernandez@example.com', 'Manuel', 'Hernández', 'José', '3434567896', 'Gómez', 1);

INSERT INTO payment_method (code, name, state)
VALUES
('PM001', 'Efectivo', 1),
('PM002', 'Tarjeta de Crédito', 1),
('PM003', 'Tarjeta de Débito', 1),
('PM004', 'Transferencia Bancaria', 1),
('PM005', 'PayPal', 1),
('PM006', 'Apple Pay', 1),
('PM007', 'Google Pay', 1),
('PM008', 'Bitcoin', 1),
('PM009', 'Cheque', 1),
('PM010', 'Transferencia Internacional', 1),
('PM011', 'Contra reembolso', 1),
('PM012', 'Pago en Tienda', 1),
('PM013', 'Criptomonedas', 1),
('PM014', 'AliPay', 1),
('PM015', 'WeChat Pay', 1),
('PM016', 'Klarna', 1),
('PM017', 'Stripe', 1),
('PM018', 'Braintree', 1),
('PM019', 'Skrill', 1),
('PM020', 'Pago por SMS', 1);

INSERT INTO company (address, email, name, phone, manager_id, state)
VALUES
('Calle 123 #45-67', 'empresa1@example.com', 'Empresa Uno', '3101234567', 101, 1),
('Avenida 25 #10-90', 'empresa2@example.com', 'Empresa Dos', '3112345678', 102, 1),
('Carrera 50 #55-33', 'empresa3@example.com', 'Empresa Tres', '3123456789', 103, 1),
('Diagonal 45 #23-56', 'empresa4@example.com', 'Empresa Cuatro', '3134567890', 104, 1),
('Calle 60 #30-90', 'empresa5@example.com', 'Empresa Cinco', '3145678901', 105, 1),
('Carrera 12 #80-12', 'empresa6@example.com', 'Empresa Seis', '3156789012', 106, 1),
('Avenida 70 #14-65', 'empresa7@example.com', 'Empresa Siete', '3167890123', 107, 1),
('Calle 90 #50-15', 'empresa8@example.com', 'Empresa Ocho', '3178901234', 108, 1),
('Carrera 100 #25-60', 'empresa9@example.com', 'Empresa Nueve', '3189012345', 109, 1),
('Avenida 120 #12-50', 'empresa10@example.com', 'Empresa Diez', '3190123456', 110, 1),
('Calle 45 #80-10', 'empresa11@example.com', 'Empresa Once', '3201234567', 111, 1),
('Carrera 20 #40-90', 'empresa12@example.com', 'Empresa Doce', '3212345678', 112, 1),
('Avenida 150 #60-30', 'empresa13@example.com', 'Empresa Trece', '3223456789', 113, 1),
('Calle 15 #90-20', 'empresa14@example.com', 'Empresa Catorce', '3234567890', 114, 1),
('Carrera 80 #10-10', 'empresa15@example.com', 'Empresa Quince', '3245678901', 115, 1),
('Avenida 25 #12-40', 'empresa16@example.com', 'Empresa Dieciséis', '3256789012', 116, 1),
('Calle 200 #30-70', 'empresa17@example.com', 'Empresa Diecisiete', '3267890123', 117, 1),
('Carrera 10 #50-80', 'empresa18@example.com', 'Empresa Dieciocho', '3278901234', 118, 1),
('Avenida 180 #70-15', 'empresa19@example.com', 'Empresa Diecinueve', '3289012345', 119, 1),
('Calle 30 #60-10', 'empresa20@example.com', 'Empresa Veinte', '3290123456', 120, 1);

INSERT INTO branch (address, email, name, phone, company_id, responsible_id, state)
VALUES
('Calle 123 #45-67', 'sucursal1@empresa1.com', 'Sucursal Principal', '3101234567', 1, 1, 1),
('Avenida 25 #10-90', 'sucursal2@empresa2.com', 'Sucursal Centro', '3112345678', 2, 2, 1),
('Carrera 50 #55-33', 'sucursal3@empresa3.com', 'Sucursal Norte', '3123456789', 3, 3, 1),
('Diagonal 45 #23-56', 'sucursal4@empresa4.com', 'Sucursal Sur', '3134567890', 4, 4, 1),
('Calle 60 #30-90', 'sucursal5@empresa5.com', 'Sucursal Este', '3145678901', 5, 5, 1),
('Carrera 12 #80-12', 'sucursal6@empresa6.com', 'Sucursal Oeste', '3156789012', 6, 6, 1),
('Avenida 70 #14-65', 'sucursal7@empresa7.com', 'Sucursal Industrial', '3167890123', 7, 7, 1),
('Calle 90 #50-15', 'sucursal8@empresa8.com', 'Sucursal Comercial', '3178901234', 8, 8, 1),
('Carrera 100 #25-60', 'sucursal9@empresa9.com', 'Sucursal Central', '3189012345', 9, 9, 1),
('Avenida 120 #12-50', 'sucursal10@empresa10.com', 'Sucursal Empresarial', '3190123456', 10, 10, 1),
('Calle 45 #80-10', 'sucursal11@empresa11.com', 'Sucursal Andina', '3201234567', 11, 11, 1),
('Carrera 20 #40-90', 'sucursal12@empresa12.com', 'Sucursal Del Río', '3212345678', 12, 12, 1),
('Avenida 150 #60-30', 'sucursal13@empresa13.com', 'Sucursal Del Valle', '3223456789', 13, 13, 1),
('Calle 15 #90-20', 'sucursal14@empresa14.com', 'Sucursal Campestre', '3234567890', 14, 14, 1),
('Carrera 80 #10-10', 'sucursal15@empresa15.com', 'Sucursal Urbana', '3245678901', 15, 15, 1),
('Avenida 25 #12-40', 'sucursal16@empresa16.com', 'Sucursal Capital', '3256789012', 16, 16, 1),
('Calle 200 #30-70', 'sucursal17@empresa17.com', 'Sucursal Altos', '3267890123', 17, 17, 1),
('Carrera 10 #50-80', 'sucursal18@empresa18.com', 'Sucursal Del Lago', '3278901234', 18, 18, 1),
('Avenida 180 #70-15', 'sucursal19@empresa19.com', 'Sucursal De Cedros', '3289012345', 19, 19, 1),
('Calle 30 #60-10', 'sucursal20@empresa20.com', 'Sucursal De Oro', '3290123456', 20, 20, 1);

INSERT INTO product (code, description, name, category_id, state)
VALUES
('P001', 'Producto de ejemplo 1', 'Producto A', 1, 1),
('P002', 'Producto de ejemplo 2', 'Producto B', 2, 1),
('P003', 'Producto de ejemplo 3', 'Producto C', 3, 1),
('P004', 'Producto de ejemplo 4', 'Producto D', 4, 1),
('P005', 'Producto de ejemplo 5', 'Producto E', 5, 1),
('P006', 'Producto de ejemplo 6', 'Producto F', 6, 1),
('P007', 'Producto de ejemplo 7', 'Producto G', 7, 1),
('P008', 'Producto de ejemplo 8', 'Producto H', 8, 1),
('P009', 'Producto de ejemplo 9', 'Producto I', 9, 1),
('P010', 'Producto de ejemplo 10', 'Producto J', 10, 1),
('P011', 'Producto de ejemplo 11', 'Producto K', 11, 1),
('P012', 'Producto de ejemplo 12', 'Producto L', 12, 1),
('P013', 'Producto de ejemplo 13', 'Producto M', 13, 1),
('P014', 'Producto de ejemplo 14', 'Producto N', 14, 1),
('P015', 'Producto de ejemplo 15', 'Producto O', 15, 1),
('P016', 'Producto de ejemplo 16', 'Producto P', 16, 1),
('P017', 'Producto de ejemplo 17', 'Producto Q', 17, 1),
('P018', 'Producto de ejemplo 18', 'Producto R', 18, 1),
('P019', 'Producto de ejemplo 19', 'Producto S', 19, 1),
('P020', 'Producto de ejemplo 20', 'Producto T', 20, 1);

INSERT INTO inventory (date, purchase_value, sale_value, stock, branch_id, product_id, state)
VALUES
('2024-01-01', 100.00, 150.00, 20, 1, 1, 1),
('2024-01-02', 120.00, 180.00, 15, 2, 2, 1),
('2024-01-03', 90.00, 140.00, 30, 3, 3, 1),
('2024-01-04', 80.00, 130.00, 25, 4, 4, 1),
('2024-01-05', 110.00, 170.00, 18, 5, 5, 1),
('2024-01-06', 150.00, 200.00, 12, 6, 6, 1),
('2024-01-07', 130.00, 190.00, 22, 7, 7, 1),
('2024-01-08', 140.00, 210.00, 10, 8, 8, 1),
('2024-01-09', 160.00, 220.00, 8, 9, 9, 1),
('2024-01-10', 125.00, 180.00, 14, 10, 10, 1),
('2024-01-11', 135.00, 200.00, 16, 11, 11, 1),
('2024-01-12', 145.00, 210.00, 20, 12, 12, 1),
('2024-01-13', 110.00, 160.00, 24, 13, 13, 1),
('2024-01-14', 115.00, 175.00, 28, 14, 14, 1),
('2024-01-15', 100.00, 150.00, 19, 15, 15, 1),
('2024-01-16', 120.00, 180.00, 23, 16, 16, 1),
('2024-01-17', 130.00, 190.00, 17, 17, 17, 1),
('2024-01-18', 140.00, 200.00, 11, 18, 18, 1),
('2024-01-19', 150.00, 210.00, 9, 19, 19, 1),
('2024-01-20', 110.00, 170.00, 21, 20, 20, 1);

INSERT INTO invoice (date, discount_value, gross_value, net_value, paym_method_id, client_id, state)
VALUES
('2024-01-01', 5.00, 150.00, 145.00, 1, 1, 1),
('2024-01-02', 10.00, 200.00, 190.00, 2, 2, 1),
('2024-01-03', 15.00, 250.00, 235.00, 3, 3, 1),
('2024-01-04', 8.00, 180.00, 172.00, 4, 4, 1),
('2024-01-05', 12.00, 220.00, 208.00, 5, 5, 1),
('2024-01-06', 7.00, 210.00, 203.00, 6, 6, 1),
('2024-01-07', 20.00, 300.00, 280.00, 7, 7, 1),
('2024-01-08', 5.00, 100.00, 95.00, 8, 8, 1),
('2024-01-09', 3.00, 130.00, 127.00, 9, 9, 1),
('2024-01-10', 10.00, 150.00, 140.00, 10, 10, 1),
('2024-01-11', 25.00, 350.00, 325.00, 11, 11, 1),
('2024-01-12', 10.00, 190.00, 180.00, 12, 12, 1),
('2024-01-13', 13.00, 210.00, 197.00, 13, 13, 1),
('2024-01-14', 6.00, 160.00, 154.00, 14, 14, 1),
('2024-01-15', 8.00, 180.00, 172.00, 15, 15, 1),
('2024-01-16', 5.00, 140.00, 135.00, 16, 16, 1),
('2024-01-17', 9.00, 220.00, 211.00, 17, 17, 1),
('2024-01-18', 10.00, 250.00, 240.00, 18, 18, 1),
('2024-01-19', 4.00, 170.00, 166.00, 19, 19, 1),
('2024-01-20', 15.00, 230.00, 215.00, 20, 20, 1);

INSERT INTO invoice_detail (discount_percentage, gross_value, net_value, quantity, product_id, invoice_id, state)
VALUES
(5.0, 50.00, 47.50, 1, 1, 1, 1),
(10.0, 100.00, 90.00, 2, 2, 1, 1),
(7.0, 150.00, 139.50, 3, 3, 2, 1),
(8.0, 200.00, 184.00, 4, 4, 2, 1),
(12.0, 250.00, 220.00, 5, 5, 3, 1),
(5.0, 120.00, 114.00, 6, 6, 3, 1),
(6.0, 180.00, 169.20, 7, 7, 4, 1),
(15.0, 90.00, 76.50, 2, 8, 4, 1),
(10.0, 130.00, 117.00, 3, 9, 5, 1),
(20.0, 60.00, 48.00, 1, 10, 5, 1),
(8.0, 180.00, 165.60, 4, 11, 6, 1),
(9.0, 170.00, 154.70, 2, 12, 6, 1),
(5.0, 90.00, 85.50, 5, 13, 7, 1),
(11.0, 220.00, 195.80, 6, 14, 7, 1),
(13.0, 140.00, 121.00, 3, 15, 8, 1),
(10.0, 160.00, 144.00, 2, 16, 8, 1),
(14.0, 110.00, 94.60, 4, 17, 9, 1),
(6.0, 140.00, 131.60, 5, 18, 9, 1),
(12.0, 180.00, 158.40, 2, 19, 10, 1),
(10.0, 150.00, 135.00, 6, 20, 10, 1);

INSERT INTO user (password, username, person_id, state)
VALUES
('password123', 'usuario1', 1, 1),
('securePass456', 'usuario2', 2, 1),
('myPass789', 'usuario3', 3, 1),
('admin2023', 'admin1', 4, 1),
('qwerty123', 'usuario4', 5, 1),
('abc123xyz', 'usuario5', 6, 1),
('P@ssw0rd', 'usuario6', 7, 1),
('1234Secure', 'usuario7', 8, 1),
('simplePass', 'usuario8', 9, 1),
('bestUser99', 'usuario9', 10, 1),
('helloWorld1', 'usuario10', 11, 1),
('passFor2023', 'usuario11', 12, 1),
('userTest', 'usuario12', 13, 1),
('newAdmin', 'admin2', 14, 1),
('userTest99', 'usuario13', 15, 1),
('PassKey2023', 'usuario14', 16, 1),
('pass123user', 'usuario15', 17, 1),
('superUser77', 'usuario16', 18, 1),
('myKeySecure', 'usuario17', 19, 1),
('finalUser', 'usuario18', 20, 1);

INSERT INTO role (code, description, name, state)
VALUES
('ROLE_ADMIN', 'Administrador con acceso completo al sistema', 'Administrador', 1),
('ROLE_USER', 'Usuario estándar con permisos básicos', 'Usuario', 1),
('ROLE_MODERATOR', 'Moderador con permisos de gestión de contenido', 'Moderador', 1),
('ROLE_GUEST', 'Usuario invitado con acceso limitado', 'Invitado', 1),
('ROLE_SUPERVISOR', 'Supervisor encargado de monitorear actividades', 'Supervisor', 1),
('ROLE_MANAGER', 'Gerente con permisos administrativos', 'Gerente', 1),
('ROLE_EDITOR', 'Editor con permisos para modificar contenido', 'Editor', 1),
('ROLE_VIEWER', 'Visualizador con permisos solo de lectura', 'Visualizador', 1),
('ROLE_DEVELOPER', 'Desarrollador con acceso a herramientas técnicas', 'Desarrollador', 1),
('ROLE_ANALYST', 'Analista encargado de evaluar datos', 'Analista', 1),
('ROLE_FINANCE', 'Rol para personal del área financiera', 'Financiero', 1),
('ROLE_HR', 'Rol para personal del área de recursos humanos', 'Recursos Humanos', 1),
('ROLE_SUPPORT', 'Rol para personal de soporte técnico', 'Soporte', 1),
('ROLE_MARKETING', 'Rol para personal del área de marketing', 'Marketing', 1),
('ROLE_SALES', 'Rol para personal del área de ventas', 'Ventas', 1),
('ROLE_CUSTOMER', 'Cliente con acceso a servicios específicos', 'Cliente', 1),
('ROLE_PARTNER', 'Socio con permisos específicos de colaboración', 'Socio', 1),
('ROLE_AUDITOR', 'Auditor con acceso para revisión de registros', 'Auditor', 1),
('ROLE_CONSULTANT', 'Consultor con permisos temporales', 'Consultor', 1),
('ROLE_OPERATOR', 'Operador encargado de tareas técnicas', 'Operador', 1);

INSERT INTO user_role (role_id, user_id, state)
VALUES
(1, 2, 1),
(2, 1, 1),
(3, 2, 1),
(4, 3, 1),
(5, 4, 1),
(6, 5, 1),
(7, 6, 1),
(8, 7, 1),
(9, 8, 1),
(10, 9, 1),
(11, 10, 1),
(12, 11, 1),
(13, 12, 1),
(14, 13, 1),
(15, 14, 1),
(16, 15, 1),
(17, 16, 1),
(18, 17, 1),
(19, 18, 1),
(20, 19, 1);

INSERT INTO view (code, description, name, path, state)
VALUES
('inicio', 'Página principal del sistema', 'Inicio', '/inicio', 1),
('tablero', 'Visualización general de datos clave', 'Tablero', '/tablero', 1),
('ajustes', 'Opciones de personalización y configuración', 'Ajustes', '/ajustes', 1),
('cuenta', 'Gestión de la cuenta de usuario', 'Cuenta', '/cuenta', 1),
('estadisticas', 'Vista de estadísticas detalladas', 'Estadísticas', '/estadisticas', 1),
('cobros', 'Sección para gestionar cobros', 'Cobros', '/cobros', 1),
('articulos', 'Control y administración de artículos', 'Artículos', '/articulos', 1),
('pedidos', 'Seguimiento y gestión de pedidos', 'Pedidos', '/pedidos', 1),
('almacen', 'Gestión del almacenamiento y stock', 'Almacén', '/almacen', 1),
('clientes', 'Sección de administración de clientes', 'Clientes', '/clientes', 1),
('transacciones', 'Registro de transacciones realizadas', 'Transacciones', '/transacciones', 1),
('soporte', 'Sección para soporte técnico', 'Soporte', '/soporte', 1),
('documentacion', 'Acceso a documentación y manuales', 'Documentación', '/documentacion', 1),
('auditoria', 'Seguimiento de auditorías del sistema', 'Auditoría', '/auditoria', 1),
('alertas', 'Vista de alertas y notificaciones', 'Alertas', '/alertas', 1),
('comunicacion', 'Plataforma de comunicación interna', 'Comunicación', '/comunicacion', 1),
('pagos', 'Gestión y procesamiento de pagos', 'Pagos', '/pagos', 1),
('publicidad', 'Herramientas para publicidad y promociones', 'Publicidad', '/publicidad', 1),
('tareas', 'Seguimiento y asignación de tareas', 'Tareas', '/tareas', 1),
('configuracion', 'Configuración avanzada del sistema', 'Configuración', '/configuracion', 1);

INSERT INTO module (code, description, name, path, state)
VALUES
('mod_inicio', 'Módulo para gestionar la página de inicio', 'Inicio', '/modulo/inicio', 1),
('mod_tablero', 'Módulo para visualizar el tablero de control', 'Tablero', '/modulo/tablero', 1),
('mod_config', 'Módulo para gestionar configuraciones generales', 'Configuración', '/modulo/configuracion', 1),
('mod_usuarios', 'Módulo para administrar usuarios del sistema', 'Usuarios', '/modulo/usuarios', 1),
('mod_perfil', 'Módulo para gestionar el perfil del usuario', 'Perfil', '/modulo/perfil', 1),
('mod_inventario', 'Módulo para controlar el inventario', 'Inventario', '/modulo/inventario', 1),
('mod_productos', 'Módulo para gestionar productos', 'Productos', '/modulo/productos', 1),
('mod_pedidos', 'Módulo para administrar pedidos de clientes', 'Pedidos', '/modulo/pedidos', 1),
('mod_reportes', 'Módulo para generar reportes y estadísticas', 'Reportes', '/modulo/reportes', 1),
('mod_ventas', 'Módulo para registrar y monitorear ventas', 'Ventas', '/modulo/ventas', 1),
('mod_soporte', 'Módulo para gestionar solicitudes de soporte', 'Soporte', '/modulo/soporte', 1),
('mod_pagos', 'Módulo para procesar pagos y transacciones', 'Pagos', '/modulo/pagos', 1),
('mod_campañas', 'Módulo para administrar campañas publicitarias', 'Campañas', '/modulo/campañas', 1),
('mod_notificaciones', 'Módulo para enviar y gestionar notificaciones', 'Notificaciones', '/modulo/notificaciones', 1),
('mod_analiticas', 'Módulo para análisis de datos avanzados', 'Analíticas', '/modulo/analiticas', 1),
('mod_finanzas', 'Módulo para controlar las finanzas', 'Finanzas', '/modulo/finanzas', 1),
('mod_proyectos', 'Módulo para gestionar proyectos internos', 'Proyectos', '/modulo/proyectos', 1),
('mod_auditoria', 'Módulo para auditorías y control interno', 'Auditoría', '/modulo/auditoria', 1),
('mod_tareas', 'Módulo para asignación y seguimiento de tareas', 'Tareas', '/modulo/tareas', 1),
('mod_ayuda', 'Módulo para ofrecer soporte y ayuda al usuario', 'Ayuda', '/modulo/ayuda', 1);

INSERT INTO module_view (id, module_id, view_id, state)
VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 2, 4, 1),
(5, 2, 5, 1),
(6, 2, 6, 1),
(7, 3, 7, 1),
(8, 3, 8, 1),
(9, 4, 9, 1),
(10, 4, 10, 1),
(11, 5, 11, 1),
(12, 5, 12, 1),
(13, 6, 13, 1),
(14, 6, 14, 1),
(15, 7, 15, 1),
(16, 7, 16, 1),
(17, 8, 17, 1),
(18, 8, 18, 1),
(19, 9, 19, 1),
(20, 10, 20, 1);

INSERT INTO role_module (id, role_id, module_id, state)
VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 2, 4, 1),
(5, 2, 5, 1),
(6, 2, 6, 1),
(7, 3, 7, 1),
(8, 3, 8, 1),
(9, 4, 9, 1),
(10, 4, 10, 1),
(11, 5, 11, 1),
(12, 5, 12, 1),
(13, 6, 13, 1),
(14, 6, 14, 1),
(15, 7, 15, 1),
(16, 7, 16, 1),
(17, 8, 17, 1),
(18, 8, 18, 1),
(19, 9, 19, 1),
(20, 10, 20, 1);

*/

DELIMITER $$

CREATE TRIGGER trg_update_invoice_total_after_insert
AFTER INSERT ON invoice_detail
FOR EACH ROW
BEGIN
    DECLARE total DOUBLE;

    -- Calcular el nuevo total basado en los detalles de la factura
    SELECT COALESCE(SUM(idetail.net_value * idetail.quantity), 0) INTO total
    FROM invoice_detail idetail
    WHERE idetail.invoice_id = NEW.invoice_id;

    -- Actualizar el total en la factura
    UPDATE invoice
    SET net_value = total
    WHERE id = NEW.invoice_id;
END$$

CREATE TRIGGER trg_update_invoice_total_after_update
AFTER UPDATE ON invoice_detail
FOR EACH ROW
BEGIN
    DECLARE total DOUBLE;

    -- Calcular el nuevo total basado en los detalles de la factura
    SELECT COALESCE(SUM(idetail.net_value * idetail.quantity), 0) INTO total
    FROM invoice_detail idetail
    WHERE idetail.invoice_id = NEW.invoice_id;

    -- Actualizar el total en la factura
    UPDATE invoice
    SET net_value = total
    WHERE id = NEW.invoice_id;
END$$

CREATE TRIGGER trg_update_invoice_total_after_delete
AFTER DELETE ON invoice_detail
FOR EACH ROW
BEGIN
    DECLARE total DOUBLE;

    -- Calcular el nuevo total basado en los detalles de la factura
    SELECT COALESCE(SUM(idetail.net_value * idetail.quantity), 0) INTO total
    FROM invoice_detail idetail
    WHERE idetail.invoice_id = OLD.invoice_id;

    -- Actualizar el total en la factura
    UPDATE invoice
    SET net_value = total
    WHERE id = OLD.invoice_id;
END$$

DELIMITER ;

-- Insertar categoría
INSERT INTO category (code, name, description, created_at, created_by, state)
VALUES ('C001', 'Category 1', 'Description of Category 1', NOW(), 1, 1);

-- Insertar productos
INSERT INTO product (code, description, name, category_id, created_at, created_by, state)
VALUES ('P001', 'Product 1 description', 'Product 1', 1, NOW(), 1, 1),
       ('P002', 'Product 2 description', 'Product 2', 1, NOW(), 1, 1);

-- Insertar cliente (persona)
INSERT INTO person (address, document_num, document_type, email, first_name, last_name, middle_name, phone, second_last_name, created_at, created_by, state)
VALUES ('123 Main St', '123456789', 'DNI', 'john.doe@example.com', 'John', 'Doe', 'Middle', '5551234567', 'Smith', NOW(), 1, 1);

-- Insertar método de pago
INSERT INTO payment_method (code, name, created_at, created_by, state)
VALUES ('CASH', 'Cash Payment', NOW(), 1, 1);

-- Insertar factura
INSERT INTO invoice (date, discount_value, gross_value, net_value, paym_method_id, client_id, created_at, created_by, state)
VALUES ('2024-11-20', 10.0, 100.0, 0.0, 1, 1, NOW(), 1, 1);

-- Insertar detalles de la factura
INSERT INTO invoice_detail (discount_percentage, gross_value, net_value, quantity, product_id, invoice_id, created_at, created_by, state)
VALUES
(5.0, 50.0, 47.5, 1, 1, 1, NOW(), 1, 1),
(10.0, 100.0, 90.0, 2, 2, 1, NOW(), 1, 1);

SELECT * FROM invoice WHERE id = 1;

SELECT * FROM invoice_detail WHERE invoice_id = 1;

SELECT id, net_value FROM invoice WHERE id = 1;
