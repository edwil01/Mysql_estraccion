use sport_dmart_compras;


CREATE TABLE Dproveedor (
                Dproveedor_id INT AUTO_INCREMENT NOT NULL,
                nom_proveedor VARCHAR(200) NOT NULL,
                PRIMARY KEY (Dproveedor_id)
);


CREATE TABLE Dproducto (
                Dproducto_id INT AUTO_INCREMENT NOT NULL,
                codigo VARCHAR(20) NOT NULL,
                nom_prod VARCHAR(50) NOT NULL,
				nom_cat VARCHAR(20) NOT NULL,
                nom_marca VARCHAR(20) NOT NULL,
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

CREATE TABLE Dusuario (
                Dusuario_id INT AUTO_INCREMENT NOT NULL,
                nom_vend VARCHAR(200) NOT NULL,
                cargo VARCHAR(20) NOT NULL,
                PRIMARY KEY (Dusuario_id)
);

CREATE TABLE hcompras (
                cant_prod_comprados VARCHAR(20) NOT NULL,
                costos VARCHAR(20) NOT NULL,
                Dfecha_id INT NOT NULL,
                Dproducto_id INT NOT NULL,
                Dusuario_id INT NOT NULL,
                Dproveedor_id INT NOT NULL,
                FOREIGN KEY (Dusuario_id) REFERENCES Dusuario (Dusuario_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (Dproveedor_id) REFERENCES Dproveedor (Dproveedor_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (Dproducto_id) REFERENCES Dproducto (Dproducto_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (Dfecha_id) REFERENCES Dfecha (Dfecha_id)
                ON UPDATE CASCADE ON DELETE CASCADE,
                PRIMARY KEY (Dusuario_id, Dproveedor_id, Dproducto_id, Dfecha_id)
                
                
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