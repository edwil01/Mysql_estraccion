use sport_dmart_ventas;

CREATE TABLE Dvendedor (
                Dvendedor_id INT AUTO_INCREMENT NOT NULL,
                nom_vend VARCHAR(100) NOT NULL,
                cargo VARCHAR(20) NOT NULL,
                PRIMARY KEY (Dvendedor_id)
);


CREATE TABLE Dcliente (
                Dcliente_id INT AUTO_INCREMENT NOT NULL,
                nom_cli VARCHAR(100) NOT NULL,
                tipo_persona VARCHAR(30) NOT NULL,
                sexo VARCHAR(20) NOT NULL,
                PRIMARY KEY (Dcliente_id)
);


CREATE TABLE Dproducto (
                Dproducto_id INT AUTO_INCREMENT NOT NULL,
                codigo VARCHAR(20) NOT NULL,
                nom_prod VARCHAR(50) NOT NULL,
                nom_cat VARCHAR(30) NOT NULL,
                nom_marca VARCHAR(30) NOT NULL,
				descripcion VARCHAR(100) NOT NULL,
                PRIMARY KEY (Dproducto_id)
);


CREATE TABLE Dfecha (
                Dfecha_id INT AUTO_INCREMENT NOT NULL,                
                fecha DATE NOT NULL,
                dia_cod VARCHAR(2) NOT NULL,
                dmi_dia_semana VARCHAR(12) NOT NULL,
                mes_cod VARCHAR(2) NOT NULL,
                dmi_mes VARCHAR(12) NOT NULL,
                dmi_trim_cod VARCHAR(1) NOT NULL,
                dmi_trimestre VARCHAR(20) NOT NULL,
                dmi_ao VARCHAR(4) NOT NULL,
                PRIMARY KEY (Dfecha_id)
);


CREATE TABLE Hventas (
                cant_prod_vendidos VARCHAR(20) NOT NULL,
                ventas VARCHAR(20) NOT NULL,
                costos VARCHAR(20) NOT NULL,
                can_clientes VARCHAR(20) NOT NULL,
                descuento DECIMAL(9,2) NOT NULL,
				Dfecha_id INT NOT NULL,
                Dproducto_id INT NOT NULL,
                Dcliente_id INT NOT NULL,
                Dvendedor_id INT NOT NULL,
                FOREIGN KEY (Dvendedor_id) REFERENCES Dvendedor (Dvendedor_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (Dcliente_id) REFERENCES Dcliente (Dcliente_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (Dproducto_id) REFERENCES Dproducto (Dproducto_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (Dfecha_id) REFERENCES Dfecha (Dfecha_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                PRIMARY KEY (Dvendedor_id, Dcliente_id, Dproducto_id, Dfecha_id)
                
                
);

/*
ALTER TABLE HVENTAs ADD CONSTRAINT dim_vendedor_hventas_fk
FOREIGN KEY (Didusuario)
REFERENCES dvendedor (Didusuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE HVENTAs ADD CONSTRAINT dim_cliente_hventas_fk
FOREIGN KEY (Didpersona)
REFERENCES dpersona (Didpersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE HVENTAs ADD CONSTRAINT dim_producto_hventas_fk
FOREIGN KEY (Didarticulo)
REFERENCES darticulo (Didarticulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE HVENTAs ADD CONSTRAINT dim_fecha_hventas_fk
FOREIGN KEY (id_dfecha)
REFERENCES dfecha (id_dfecha)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
*/