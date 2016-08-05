<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" units="mm" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>gvmag</se:Name>
    <UserStyle>
      <se:Name>gvmag</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>centralt gvmagasin</se:Name>
          <se:Description>
            <se:Title>centralt gvmagasin</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%centralt%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00aa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">2.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>sidomagasin</se:Name>
          <se:Description>
            <se:Title>sidomagasin</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%sidomag%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00aa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.2</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">4 2</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>huvudmagasin</se:Name>
          <se:Description>
            <se:Title>huvudmagasin</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%huvudmag%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00aa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.2</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>annat magasin</se:Name>
          <se:Description>
            <se:Title>annat magasin</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsLike wildCard="%" singleChar="?" escapeChar="!">
              <ogc:Function name="lower">
                <ogc:PropertyName>typ</ogc:PropertyName>
              </ogc:Function>
              <ogc:Literal>%annat%</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00aa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 2</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>ospecificerat grundvattenmagasin</se:Name>
          <se:Description>
            <se:Title>ospecificerat grundvattenmagasin</se:Title>
          </se:Description>
          <!--Parser Error: syntax error, unexpected ELSE - Expression was: ELSE-->
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#aa55ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">square</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
