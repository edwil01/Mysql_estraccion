use sport_dmart_compras;
SET lc_time_names = 'es_ES';
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- SELECT @@lc_time_names;
-- set @day_offset = 1; -- sunday SET DATEFIRST 1 ;  

insert into Dproducto (
	codigo,
    nom_prod,
    nom_cat,
    nom_marca
)
SELECT  
	p.codigo, p.nom_prod,
    c.nom_cat,
    m.nom_marca
    
FROM sport_gumer.producto as p
	inner join sport_gumer.categoria as c on p.categoria_id= c.categoria_id
    inner join sport_gumer.marca as m on p.marca_id= m.marca_id;
    
insert into Dfecha (
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
    ,day(pe.fecha_hora ) AS COD_DIA
    ,DAYNAME(pe.fecha_hora ) AS DIA_SEMANA
	,MONTH(pe.fecha_hora ) AS COD_MES
	,MONTHNAME(pe.fecha_hora ) AS DES_MES
	,QUARTER( pe.fecha_hora ) AS COD_TRIMESTRE
	,CONCAT('Trimestre ', QUARTER(pe.fecha_hora )) AS DES_TRIMESTRE
	,YEAR(pe.fecha_hora ) AS COD_AÑO
FROM sport_gumer.ingreso as pe WHERE pe.fecha_hora IS NOT NULL
       GROUP BY date_format(pe.fecha_hora, '%Y-%m-%d')
       ORDER BY date_format(pe.fecha_hora, '%Y-%m-%d');

insert into Dproveedor (
	nom_proveedor
)
SELECT  u.nom_proveedor FROM sport_gumer.proveedor as u;

insert into Dusuario (
	nom_vend,
    cargo
)
SELECT  v.nom_vend, v.cargo FROM sport_gumer.usu_vendedor as v;

insert into hcompras (
	Dfecha_id,
    Dproducto_id,
    Dusuario_id,
    Dproveedor_id,
	cant_prod_comprados,
    costos
    
)
SELECT 
DF.Dfecha_id,
DP.Dproducto_id,
DPR.Dproveedor_id,
DUSU.Dusuario_id,
sum(G.Cantidad) as CANT_UNID,
sum(G.Costos) as COSTOS

FROM (
	SELECT  
		date_format(pe.fecha_hora, '%Y-%m-%d') AS fecha
		,p.codigo
		 ,p.nom_prod as Producto
		 ,c.nom_cat as Categoria
         ,m.nom_marca
		,ped.cantidad
		,ped.cantidad*ped.precio_compra as costos
        ,prov.nom_proveedor
        ,u.nom_vend
	FROM sport_gumer.ingreso as pe
        inner join sport_gumer.detalle_ingreso as ped on pe.ingreso_id= ped.ingreso_id 
		inner join sport_gumer.producto as p on ped.producto_id= p.producto_id
        inner join sport_gumer.marca as m on p.marca_id= m.marca_id
		inner join sport_gumer.categoria as c on p.categoria_id= c.categoria_id 
        inner join sport_gumer.proveedor as prov on pe.proveedor_id= prov.proveedor_id 
        inner join sport_gumer.usu_vendedor as u on pe.usu_vend_id= u.usu_vend_id 
	)  AS G
    
    inner join Dproducto AS DP ON G.codigo = DP.codigo
    inner join Dfecha AS DF ON G.fecha = DF.fecha
    inner join Dproveedor AS DPR ON G.nom_proveedor = DPR.nom_proveedor
    inner join Dusuario AS DUSU ON G.nom_vend = DUSU.nom_vend
	GROUP BY DP.Dproducto_id, DF.Dfecha_id, DPR.Dproveedor_id, DUSU.Dusuario_id
     
;