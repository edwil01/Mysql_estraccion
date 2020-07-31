use sport_dmart_ventas;
SET lc_time_names = 'es_ES';
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- SELECT @@lc_time_names;
-- set @day_offset = 1; -- sunday SET DATEFIRST 1 ;  

insert into Dproducto (
	codigo,
	nom_prod, 
	nom_cat,
	nom_marca,
    descripcion
)
SELECT  
	p.codigo, p.nom_prod,
    c.nom_cat,
    m.nom_marca,
    p.descripcion
    	
FROM sport_gumer.producto as p
	inner join sport_gumer.categoria as c on p.categoria_id= c.categoria_id
    inner join sport_gumer.marca as m on p.marca_id= m.marca_id;
    
insert into dfecha (
	fecha,
    dia_cod,
    dmi_dia_semana,
    mes_cod	,
    dmi_mes,
    dmi_trim_cod,
    dmi_trimestre,
	dmi_ao
)
SELECT 
	date_format(pe.fecha_hora, '%Y-%m-%d')  as fecha
    ,DAY(pe.fecha_hora ) AS COD_DIA
    ,DAYNAME(pe.fecha_hora ) AS DIA_SEMANA
	,MONTH(pe.fecha_hora ) AS COD_MES
	,MONTHNAME(pe.fecha_hora ) AS DES_MES
	,QUARTER( pe.fecha_hora ) AS COD_TRIMESTRE
	,CONCAT('Trimestre ', QUARTER(pe.fecha_hora )) AS DES_TRIMESTRE
	,YEAR(pe.fecha_hora ) AS COD_AÑO
FROM sport_gumer.venta as pe WHERE pe.fecha_hora IS NOT NULL
       GROUP BY date_format(pe.fecha_hora, '%Y-%m-%d')
       ORDER BY date_format(pe.fecha_hora, '%Y-%m-%d');

insert into Dcliente (
	nom_cli,
    tipo_persona,
    sexo
)
SELECT  c.nom_cli, c.tipo_persona, c.sexo FROM sport_gumer.cliente as c;

insert into Dvendedor (
	nom_vend,
    cargo
)
SELECT  v.nom_vend, v.cargo FROM sport_gumer.usu_vendedor as v;

insert into Hventas (
	Dfecha_id,
    Dproducto_id,
    Dcliente_id,
    Dvendedor_id,
    ventas,
	cant_prod_vendidos,
    costos,
    descuento,
    can_clientes
    
)
SELECT 
DT.Dfecha_id,
DP.Dproducto_id,
DCLI.Dcliente_id,
DVEND.Dvendedor_id,
sum(G.Ventas) as VENTAS,
sum(G.Cantidad) as CANT_UNID,
sum(G.Costos) as COSTOS,
sum(G.Descuento) as DESCTOS,
COUNT(DISTINCT G.nom_cli) AS Cant_clientes

FROM (
	SELECT  
		date_format(pe.fecha_hora, '%Y-%m-%d') AS fecha
		,p.codigo
		 ,p.nom_prod
		 ,c.nom_cat
		,ped.cantidad
		,ped.cantidad*ped.precio_compra as costos
		,(ped.cantidad*ped.precio_venta) - ped.descuento  as ventas
		,ped.descuento
        ,cli.nom_cli
        ,v.nom_vend
	FROM sport_gumer.venta as pe
		inner join sport_gumer.detalle_venta as ped on pe.venta_id= ped.venta_id 
		inner join sport_gumer.producto as p on ped.producto_id= p.producto_id
		inner join sport_gumer.categoria as c on p.categoria_id= c.categoria_id 
        inner join sport_gumer.cliente as cli on pe.cliente_id= cli.cliente_id 
        inner join sport_gumer.usu_vendedor as v on pe.usu_vend_id= v.usu_vend_id 
	)  AS G
    
    inner join Dproducto AS DP ON G.codigo = DP.codigo
    inner join Dfecha AS DT ON G.fecha = DT.fecha
    inner join Dcliente AS DCLI ON G.nom_cli = DCLI.nom_cli
    inner join Dvendedor AS DVEND ON G.nom_vend = DVEND.nom_vend
	GROUP BY DP.Dproducto_id, DT.Dfecha_id, DCLI.Dcliente_id, DVEND.Dvendedor_id
     
;