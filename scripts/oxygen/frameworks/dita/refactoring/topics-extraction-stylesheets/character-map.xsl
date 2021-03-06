<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xd:doc>
        <xd:desc>A mapping between "special" characters and their ASCII equivalent. 
        Some characters are not accepted and they will be replaced with underline symbol(_).
        
        Users can change/update this list.</xd:desc>
    </xd:doc>
    <xsl:variable name="char-map" as="map(xs:string, xs:string)" select="map{
        'ß' : 'ss',
        'ü' : 'ue',
        'Ü' : 'UE',
        'ä' : 'ae',
        'Ä' : 'AE',
        'ö' : 'oe',
        'Ö' : 'OE',
        'À' : 'A',
        'Á' : 'A',
        'Â' : 'A',
        'Ã' : 'A',
        'Å' : 'A',
        'Ç' : 'C',
        'È' : 'E',
        'É' : 'E',
        'Ê' : 'E',
        'Ë' : 'E',
        'Ì' : 'I',
        'Í' : 'I',
        'Î' : 'I',
        'Ï' : 'I',
        'Ñ' : 'N',
        'Ò' : 'O',
        'Ó' : 'O',
        'Ô' : 'O',
        'Õ' : 'O',
        'Ù' : 'U',
        'Ú' : 'U',
        'Û' : 'U',
        'Ý' : 'Y',
        'à' : 'a',
        'á' : 'a',
        'â' : 'a',
        'ã' : 'a',
        'å' : 'a',
        'ç' : 'c',
        'è' : 'e',
        'é' : 'e',
        'ê' : 'e',
        'ë' : 'e',
        'ì' : 'i',
        'í' : 'i',
        'î' : 'i',
        'ï' : 'i',
        'ñ' : 'n',
        'ò' : 'o',
        'ó' : 'o',
        'ô' : 'o',
        'õ' : 'o',
        'ù' : 'u',
        'ú' : 'u',
        'û' : 'u',
        'ý' : 'y',
        'ÿ' : 'y',
        'Š' : 'S',
        'š' : 's',
        'Ÿ' : 'Y',
        'Ž' : 'Z',
        'ž' : 'z',
        '¡' : '_',
        '¢' : '_',
        '£' : '_',
        '¤' : '_',
        '¥' : '_',
        '¦' : '_',
        '§' : '_',
        '¨' : '_',
        '©' : '_',
        'ª' : '_',
        '«' : '_',
        '¬' : '_',
        '­' : '_',
        '®' : '_',
        '¯' : '_',
        '°' : '_',
        '±' : '_',
        '²' : '_',
        '³' : '_',
        '´' : '_',
        'µ' : '_',
        '¶' : '_',
        '·' : '_',
        '¸' : '_',
        '¹' : '_',
        'º' : '_',
        '»' : '_',
        '¼' : '_',
        '½' : '_',
        '¾' : '_',
        '¿' : '_',
        'Æ' : '_',
        'Ð' : '_',
        '×' : '_',
        'Ø' : '_',
        'Þ' : '_',
        'æ' : '_',
        'ð' : '_',
        '÷' : '_',
        'ø' : '_',
        'þ' : '_',
        'Œ' : '_',
        'œ' : '_',
        'ƒ' : '_',
        'ˆ' : '_',
        '˜' : '_',
        '–' : '_',
        '—' : '_',
        '‘' : '_',
        '’' : '_',
        '‚' : '_',
        '“' : '_',
        '”' : '_',
        '„' : '_',
        '†' : '_',
        '‡' : '_',
        '•' : '_',
        '…' : '_',
        '‰' : '_',
        '‹' : '_',
        '›' : '_'
        }"/>
    
</xsl:stylesheet>