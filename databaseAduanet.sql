SELECT 
	C001TIPOPE AS 'IMPORTACION', 
    C001ADUSEC AS 'ADUANA', 
    D001FECARR AS'FECHA', 
    F001TIPCAM AS 'TIPO DE CAMBIO', 
    ##pedimentos, contribuciones
    F001TOTFAC AS'IVA', 
    C001CVEDOC AS 'CLAVE',
    F001FLETES AS 'FLETES',
	F001VALSEG AS 'SEGUROS',
    F001EMBALA AS 'EMBALAJES',
    F001OTRINC AS 'OTROS', 
    F001TASDT1 AS 'DTA',
    ##datos generales y partida
    ##partidas AT016
    N016VALCOM AS 'VALOR COMERCIAL', 
    N001VALADU AS'VALOR ADUANA',
    ##Identificadores Si/No AT041
    L041BANCF AS 'CONSOLIDADO',
	F001TASPRE AS 'PREVALIDACION', 
    F001TOTFAC AS 'FACTURA', 
    ##factura
    D005FECFAC AS'FECHA FACTURA', 
    F001FACMEX AS 'FACTOR MONEDA',
    ##Observaciones a nivel partida
    'NUM_PART',
    #Materia Prima
    'TIPO BIEN', 
    ##Fraccion Fracciones Partidas AT016
    C016FRAC AS 'FRACCION IMPORTACION',
    ##descripcion de mercancia AT016
	C016DESMER AS 'DES_MERC',
    #partidas
    'TASA',
    #partidas
    'TIPO TASA',
    #partidas cantidad comercial
    'UNIDAD',
    ##partidas despues de descripcion
    F016PREUNI AS 'PRECIO',
    #cantidad comercial
     'CANTIDAD', 
    C001ORIGEN AS'ORIGEN',
    #facturas importacion es vendedor / [siempre] exportacion es comprador
    'VENDEDOR', 
    C001CONFOR AS'FORMA DE PAGO', 
    ##facturas AT604 
    C604CVEINC AS'INCOTERM', 
    F001TASREU AS'PAGA IMPUESTOS PARA TLCAN',
	#trato preferencial TLC
    'PAGA IMPUESTOS PARA TLCUEM',
    #material de empaque, esta en partida
    'EB',
    #Si se tiene 
    'MONTO EB',	
    #factura
    'COVE', 
    F001TASMUL AS 'MULTAS', 
    F001TASREC AS 'RECARGOS',
    #contraprestacion
    'CNT',
    #peso por parte
    'PESO NETO',
    #peso total
    F001PESO AS 'PESO BRUTO' 
FROM 
	at001 AS pedGeneral INNER JOIN
    at005 AS factura ON (pedGeneral.C001NUMPED = factura.C005NUMPED) INNER JOIN
	at016 AS fracciones ON (pedGeneral.C001NUMPED = fracciones.C016NUMPED) INNER JOIN
    at019 AS partida ON (pedGeneral.C001NUMPED = partida.C019NUMPED) INNER JOIN
    at041 AS consolidado ON (pedGeneral.C001NUMPED = consolidado.C041NUMPED) INNER JOIN
    at604 AS datosCabecera ON (pedGeneral.C001NUMPED = datosCabecera.C604NUMPED) 
    
# AT016 AT604 AT041
WHERE 
	(date(pedGeneral.D001FECEP) BETWEEN '2016-01-01' AND '2016-01-31') AND 
    (pedGeneral.C001ADUSEC = 'Laredo' OR pedGeneral.C001ADUSEC = 'Colombia') AND 
    (pedGeneral.C001CVECLI = 'ClaveCliente');

#Campos del reporte Reporte
#IMPORTACION	ADUANA	FECHA	TIPO DE CAMBIO	IVA	CLAVE	FLETES	SEGUROS	EMBALAJES	OTROS	DTA	VALOR COMERCIAL	VALOR ADUANA	CONSOLIDADO	PREVALIDACION	FACTURA	FECHA FACTURA	FACTOR MONEDA	NUM_PART	TIPO BIEN	FRACCION IMPORTACION	DES_MERC	TASA	TIPO TASA	UNIDAD	PRECIO	CANTIDAD	ORIGEN	VENDEDOR	FORMA DE PAGO	INCOTERM	PAGA IMPUESTOS PARA TLCAN	PAGA IMPUESTOS PARA TLCUEM	EB	MONTO EB	COVE	MULTAS	RECARGOS	CNT	PESO NETO	PESO BRUTO
select *
from at001;