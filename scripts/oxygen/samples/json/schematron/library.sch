<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:title>Schema for JSON Library Document</sch:title>
    
    <!-- Allowed literature genres -->
    <sch:let name="literatureGenres" value="//literatureGenres/text()"/>
    
    <sch:phase id="PhaseOne">
        <sch:active pattern="PropsCheckingPhaseOne"/>
    </sch:phase>
    <sch:phase id="PhaseTwo">
        <sch:active pattern="PropsCheckingPhaseTwo"/>
    </sch:phase>
    
    <sch:pattern id="PropsCheckingPhaseOne">
        <!-- The 'genre' property should be none but one of the items declared in 'literatureGenres' property -->
        <sch:rule context="genre">
            <sch:let name="genre" value="text()"/>
            <sch:assert test="normalize-space($genre) = $literatureGenres">    
                Wrong genre: '<sch:value-of select="$genre"/>'. See the 'literatureGenres' property for the permitted ones.
            </sch:assert>    
        </sch:rule>
        
        <!-- The folowing rule checks the number of the "author"'s properties and the order they appear in the document -->
        <sch:rule context="author">
            <sch:let name="authorCh" value="child::*"/>
            <sch:assert test="count($authorCh) = 3 and $authorCh[1]/name() = 'name' and $authorCh[2]/name() = 'birth_year' and $authorCh[3]/name() = 'short_bio'">
                The number and the order of 'author' properties are both fixed: 'name', 'birth_year', 'short_bio'.
            </sch:assert>    
        </sch:rule>
     
        <sch:rule context="birth_year">
            <!-- A further rule for 'birth_year' properties: the publishing year of a book cannot precede its author's birthday -->
            <sch:let name="py" value="number(parent::author/parent::authors/preceding-sibling::publishing_year/text())"/>
            <sch:let name="by" value="number(text())"/>
            <sch:assert test="$py gt $by">
                The publishing year (<sch:value-of select="$py"/>) precedes this author's birth year (<sch:value-of select="$by"/>).
            </sch:assert>    
        </sch:rule>
        
        <sch:rule context="short_bio">
            <!-- A further rule for 'short_bio' properties: they cannot be empty -->
            <sch:assert test="normalize-space() != ''">
                All 'author's should have non empty values for 'short_bio' properties.
            </sch:assert>
        </sch:rule>
        
        <!-- ISBN codes only contain digits -->
        <sch:rule context="ISBN-10">
            <sch:assert test="number(.)">
                ISBN codes must contain none but digits.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="PropsCheckingPhaseTwo">
        <!-- 'short_bio' property's value/content is limited to max 200 characters; an warning is issued when exceeding the limit -->
        <sch:rule context="short_bio">
            <sch:let name="shortBioLenght" value="string-length()"/>
            <sch:assert test="$shortBioLenght le 200"  role="warning">
                "short_bio" should be limited to max 200 characters (actual lenght: <sch:value-of select="$shortBioLenght"/>).
            </sch:assert>
        </sch:rule>
        
        <!-- 'short_desc' property's value/content is limited to max 250 characters; an warning is issued when exceeding the limit -->
        <sch:rule context="short_desc">
            <sch:let name="shortDescLenght" value="string-length()"/>
            <sch:assert test="$shortDescLenght le 250" role="warning">
                "short_desc" should be limited to max 250 characters (actual lenght: <sch:value-of select="$shortDescLenght"/>).
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>