use tienda_dmart_compras;
SET lc_time_names = 'es_ES';
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- SELECT @@lc_time_names;
-- set @day_offset = 1; -- sunday SET DATEFIRST 1 ;  

insert into darticulo (
	codigo,
    nombre,
    stock,
    nombre_1,
    precio_compra
)
SELECT  
	p.codigo, p.nombre as Nom_producto, 
    p.stock,
    c.nombre_1 as Nom_categoria,
	d.precio_compra
    
	
FROM mi_tienda.articulo as p
	inner join mi_tienda.categoria as c on p.idcategoria= c.idcategoria
    inner join mi_tienda.detalle_ingreso as d on p.idarticulo= d.idarticulo;
    
    
    
insert into dfecha (
	fecha,
    dmi_dia_semana,
    mes_cod	,
    dmi_mes,
    dmi_trim_cod,
    dmi_trimestre,
	dmi_ao
)
SELECT 
	date_format(pe.fecha_hora, '%Y-%m-%d')  as fecha
    ,DAYNAME(pe.fecha_hora ) AS DIA_SEMANA
	,MONTH(pe.fecha_hora ) AS COD_MES
	,MONTHNAME(pe.fecha_hora ) AS DES_MES
	,QUARTER( pe.fecha_hora ) AS COD_TRIMESTRE
	,CONCAT('Trimestre ', QUARTER(pe.fecha_hora )) AS DES_TRIMESTRE
	,YEAR(pe.fecha_hora ) AS COD_AÑO
FROM mi_tienda.ingreso as pe WHERE pe.fecha_hora IS NOT NULL
       GROUP BY date_format(pe.fecha_hora, '%Y-%m-%d')
       ORDER BY date_format(pe.fecha_hora, '%Y-%m-%d');



insert into hcompras (
	id_dfecha,
    Didarticulo,
	cant_prod_comprados,
    compras
    
)
SELECT 
DT.id_dfecha,
DP.Didarticulo,
sum(G.Cantidad) as CANT_UNID,
sum(G.Compras) as COMPRAS


FROM (
	SELECT  
		date_format(pe.fecha_hora, '%Y-%m-%d') AS fecha
		,p.codigo
		 ,p.nombre as Producto
		 ,c.nombre_1 as Categoria
		,ped.cantidad
		,ped.cantidad*ped.precio_compra as compras
	FROM mi_tienda.ingreso as pe
        inner join mi_tienda.detalle_ingreso as ped on pe.idingreso= ped.idingreso
		inner join mi_tienda.articulo as p on ped.idarticulo= p.idarticulo
		inner join mi_tienda.categoria as c on p.idcategoria= c.idcategoria 
        
	)  AS G
    
    inner join darticulo AS DP ON G.codigo = DP.codigo
    inner join dfecha AS DT ON G.fecha = DT.fecha
	GROUP BY DP.Didarticulo, DT.id_dfecha
     
;