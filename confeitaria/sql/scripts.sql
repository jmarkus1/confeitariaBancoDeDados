CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_venda DECIMAL(10, 2) NOT NULL,
    unidade_medida VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS fornecedor (
    id SERIAL PRIMARY KEY,
    razão_social VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE,
    tel_contato VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereço TEXT
);

CREATE TABLE IF NOT EXISTS ingrediente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_estoque DECIMAL(10,2),
    id_fornecedor INT REFERENCES fornecedor(id)
);

CREATE TABLE IF NOT EXISTS pedido (
    id SERIAL PRIMARY KEY,
    data_hora_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_prevista_entrega DATE,
    status_pedido VARCHAR(50),
    tipo_entrega VARCHAR(50),
    valor_total DECIMAL(10,2),
    id_cliente INT REFERENCES cliente(id)
);

CREATE TABLE IF NOT EXISTS item_pedido (
    id_pedido INT REFERENCES pedido(id),
    id_produto INT REFERENCES produtos(id),
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto)
);



INSERT INTO fornecedor (razão_social, cnpj, tel_contato) VALUES 
('Atacadão Doces', '12345678000199', '8332221100'),
('Moinho Central', '98765432000188', '8332224455'),
('Laticínios Vale', '55566677000122', '8332711234')
ON CONFLICT (cnpj) DO NOTHING;


INSERT INTO cliente (nome, telefone, email, endereço) VALUES 
('Jefferson Silva', '83999990000', 'jeff@email.com', 'Guarabira, Centro'),
('Rayanne Karen', '83988881111', 'maria@email.com', 'Guarabira, Nordeste'),
('Ricardo Santos', '83966663333', 'ricardo@email.com', 'Pirpirituba, PB'),
('Fernanda Costa', '83955554444', 'fefe@email.com', 'Nordeste, Guarabira'),
('Anthony Moura', '83998354295', 'an@gmail.com', 'Sertãozinho, PB' )
ON CONFLICT DO NOTHING;


INSERT INTO produtos (nome, descricao, preco_venda, unidade_medida) VALUES 
('Bolo de Chocolate', 'Fofinho com cobertura', 25.00, 'Unidade'),
('Brigadeiro Gourmet', 'Chocolate belga', 2.50, 'Unidade'),
('Palha Italiana', 'Com leite ninho', 5.00, 'Unidade'),
('Bento Cake', 'Personalizado', 35.00, 'Unidade'),
('Combo Festa P', 'Bolo + 50 doces', 150.00, 'Combo'),
('Torta de Morango', 'Massa amanteigada', 55.00, 'Unidade')
ON CONFLICT DO NOTHING;


INSERT INTO ingrediente (nome, quantidade_estoque, id_fornecedor) VALUES 
('Cacau em Pó', 50.0, (SELECT id FROM fornecedor WHERE razão_social = 'Atacadão Doces' LIMIT 1)),
('Farinha de Trigo', 200.0, (SELECT id FROM fornecedor WHERE razão_social = 'Moinho Central' LIMIT 1)),
('Manteiga Especial', 15.0, (SELECT id FROM fornecedor WHERE razão_social = 'Laticínios Vale' LIMIT 1)),
('Açúcar Mascavo', 30.0, NULL) 
ON CONFLICT DO NOTHING;


INSERT INTO pedido (data_prevista_entrega, status_pedido, tipo_entrega, valor_total, id_cliente) VALUES 
('2026-03-10', 'Finalizado', 'Entrega', 250.00, (SELECT id FROM cliente WHERE nome = 'Jefferson Silva' LIMIT 1)),
('2026-03-12', 'Pendente', 'Retirada', 15.00, (SELECT id FROM cliente WHERE nome = 'Maria Oliveira' LIMIT 1)),
('2026-03-15', 'Finalizado', 'Entrega', 75.00, (SELECT id FROM cliente WHERE nome = 'Ricardo Santos' LIMIT 1)),
('2026-03-20', 'Finalizado', 'Entrega', 180.00, (SELECT id FROM cliente WHERE nome = 'Fernanda Costa' LIMIT 1))
ON CONFLICT DO NOTHING;

INSERT INTO item_pedido (id_pedido, id_produto, quantidade) 
SELECT p.id, pr.id, 2 FROM pedido p, produtos pr 
WHERE p.valor_total = 250.00 AND pr.nome = 'Combo Festa P'
ON CONFLICT DO NOTHING;

INSERT INTO item_pedido (id_pedido, id_produto, quantidade) 
SELECT p.id, pr.id, 10 FROM pedido p, produtos pr 
WHERE p.valor_total = 15.00 AND pr.nome = 'Brigadeiro Gourmet'
ON CONFLICT DO NOTHING;


SELECT * FROM fornecedor;
SELECT * FROM cliente;
SELECT * FROM ingrediente;
SELECT * FROM pedido;
SELECT * FROM produtos;



