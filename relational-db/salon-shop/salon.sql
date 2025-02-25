-- Criar o banco de dados
CREATE DATABASE salon;

-- Conectar ao banco de dados
\c salon;

-- Criar a tabela de clientes
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- Criar a tabela de serviços
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Criar a tabela de agendamentos
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    service_id INT NOT NULL REFERENCES services(service_id),
    time VARCHAR(50) NOT NULL
);

-- Inserir serviços iniciais
INSERT INTO services (service_id, name) VALUES 
(1, 'Cut'),
(2, 'Color'),
(3, 'Perm');