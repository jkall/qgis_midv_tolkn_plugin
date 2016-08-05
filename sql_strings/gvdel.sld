<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" units="mm" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>gvdel</se:Name>
    <UserStyle>
      <se:Name>gvdel</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>fast vattendelare</se:Name>
          <se:Description>
            <se:Title>fast vattendelare</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%fast%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#d185ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>hydraulisk gräns</se:Name>
          <se:Description>
            <se:Title>hydraulisk gräns</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%hydraulisk%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#a270d4</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 2</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>rörlig vattendelare</se:Name>
          <se:Description>
            <se:Title>rörlig vattendelare</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%rörlig%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>circle</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="fill">#aa55ff</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#aa55ff</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>2</se:Size>
                </se:Graphic>
                <se:Gap>
                  <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
                    <ogc:Literal>3.5</ogc:Literal>
                  </ogc:Filter>
                </se:Gap>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name></se:Name>
          <!--Parser Error: syntax error, unexpected ELSE - Expression was: ELSE-->
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#a270d4</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 2</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
