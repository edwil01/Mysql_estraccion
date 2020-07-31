use tienda_dmart_compras;

CREATE TABLE darticulo (
                Didarticulo INT AUTO_INCREMENT NOT NULL,
                codigo VARCHAR(20) NOT NULL,
                nombre VARCHAR(50) NOT NULL,
                stock VARCHAR(50) NOT NULL,
                nombre_1 VARCHAR(20) NOT NULL,
                precio_compra DECIMAL(9,2) NOT NULL,
                PRIMARY KEY (Didarticulo)
);


CREATE TABLE dfecha (
                id_dfecha INT AUTO_INCREMENT NOT NULL,
                fecha DATE NOT NULL,
                dmi_dia_semana VARCHAR(12) NOT NULL,
                mes_cod VARCHAR(2) NOT NULL,
                dmi_mes VARCHAR(12) NOT NULL,
                dmi_trim_cod VARCHAR(1) NOT NULL,
                dmi_trimestre VARCHAR(20) NOT NULL,
                dmi_ao VARCHAR(4) NOT NULL,
                PRIMARY KEY (id_dfecha)
);


CREATE TABLE hcompras (
                cant_prod_comprados VARCHAR(20) NOT NULL,
                compras VARCHAR(20) NOT NULL,
                id_dfecha INT NOT NULL,
                Didarticulo INT NOT NULL,
                FOREIGN KEY (Didarticulo) REFERENCES darticulo (Didarticulo)
                ON UPDATE CASCADE ON DELETE CASCADE,
                FOREIGN KEY (id_dfecha) REFERENCES dfecha (id_dfecha)
                ON UPDATE CASCADE ON DELETE CASCADE,
                PRIMARY KEY (Didarticulo, id_dfecha)
                
                
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