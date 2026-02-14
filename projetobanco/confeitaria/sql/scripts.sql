CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

INSERT INTO produtos (nome, descricao, preco) VALUES ('Bolo de Chocolate', 'Bolo fofinho', 25.00);
