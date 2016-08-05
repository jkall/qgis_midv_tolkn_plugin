<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" units="mm" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>tillromr</se:Name>
    <UserStyle>
      <se:Name>tillromr</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>ingen angiven typ av tillrinningsområde</se:Name>
          <se:Description>
            <se:Title>ingen angiven typ av tillrinningsområde</se:Title>
          </se:Description>
          <!--Parser Error: syntax error, unexpected ELSE - Expression was: ELSE-->
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.26</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">4 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>typ av tillrinningsområde</se:Name>
          <se:Description>
            <se:Title>typ av tillrinningsområde</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typ</ogc:PropertyName>
                <ogc:Literal>a</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typ</ogc:PropertyName>
                <ogc:Literal>b</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typ</ogc:PropertyName>
                <ogc:Literal>c</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:Or>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.26</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>typ a</se:Name>
          <se:Description>
            <se:Title>typ a</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>a</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>b</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>c</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typ</ogc:PropertyName>
                <ogc:Literal>a</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>horline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.26</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>3</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>horline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.26</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>3</se:Size>
                  <se:Rotation>
                    <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
                      <ogc:Literal>90</ogc:Literal>
                    </ogc:Filter>
                  </se:Rotation>
                  <se:Displacement>
                    <se:DisplacementX>0</se:DisplacementX>
                    <se:DisplacementY>0</se:DisplacementY>
                  </se:Displacement>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>typ b</se:Name>
          <se:Description>
            <se:Title>typ b</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>a</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>b</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>c</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typ</ogc:PropertyName>
                <ogc:Literal>b</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>horline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.26</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>typ c</se:Name>
          <se:Description>
            <se:Title>typ c</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>a</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>b</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typ</ogc:PropertyName>
                  <ogc:Literal>c</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typ</ogc:PropertyName>
                <ogc:Literal>c</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>horline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#000000</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.26</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>9</se:Size>
                  <se:Rotation>
                    <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
                      <ogc:Literal>45</ogc:Literal>
                    </ogc:Filter>
                  </se:Rotation>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Andel av grundvattenbildningen som når magasinet</se:Name>
          <se:Description>
            <se:Title>Andel av grundvattenbildningen som når magasinet</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:Not>
                <ogc:PropertyIsNull>
                  <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                </ogc:PropertyIsNull>
              </ogc:Not>
              <ogc:PropertyIsNotEqualTo>
                <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                <ogc:Literal></ogc:Literal>
              </ogc:PropertyIsNotEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.6</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>100%</se:Name>
          <se:Description>
            <se:Title>100%</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:And>
                <ogc:Not>
                  <ogc:PropertyIsNull>
                    <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  </ogc:PropertyIsNull>
                </ogc:Not>
                <ogc:PropertyIsNotEqualTo>
                  <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  <ogc:Literal></ogc:Literal>
                </ogc:PropertyIsNotEqualTo>
              </ogc:And>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                <ogc:Literal>99.9</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ed0000</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.25</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>75-100%</se:Name>
          <se:Description>
            <se:Title>75-100%</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:And>
                <ogc:And>
                  <ogc:Not>
                    <ogc:PropertyIsNull>
                      <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                    </ogc:PropertyIsNull>
                  </ogc:Not>
                  <ogc:PropertyIsNotEqualTo>
                    <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                    <ogc:Literal></ogc:Literal>
                  </ogc:PropertyIsNotEqualTo>
                </ogc:And>
                <ogc:PropertyIsGreaterThan>
                  <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  <ogc:Literal>74.9</ogc:Literal>
                </ogc:PropertyIsGreaterThan>
              </ogc:And>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ff7f00</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.25</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>50-75%</se:Name>
          <se:Description>
            <se:Title>50-75%</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:And>
                <ogc:And>
                  <ogc:Not>
                    <ogc:PropertyIsNull>
                      <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                    </ogc:PropertyIsNull>
                  </ogc:Not>
                  <ogc:PropertyIsNotEqualTo>
                    <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                    <ogc:Literal></ogc:Literal>
                  </ogc:PropertyIsNotEqualTo>
                </ogc:And>
                <ogc:PropertyIsGreaterThan>
                  <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  <ogc:Literal>49.9</ogc:Literal>
                </ogc:PropertyIsGreaterThan>
              </ogc:And>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                <ogc:Literal>75</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#f1f453</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.25</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>25-50%</se:Name>
          <se:Description>
            <se:Title>25-50%</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:And>
                <ogc:And>
                  <ogc:Not>
                    <ogc:PropertyIsNull>
                      <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                    </ogc:PropertyIsNull>
                  </ogc:Not>
                  <ogc:PropertyIsNotEqualTo>
                    <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                    <ogc:Literal></ogc:Literal>
                  </ogc:PropertyIsNotEqualTo>
                </ogc:And>
                <ogc:PropertyIsGreaterThan>
                  <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  <ogc:Literal>24.9</ogc:Literal>
                </ogc:PropertyIsGreaterThan>
              </ogc:And>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#33a02c</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.25</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>&lt;25%</se:Name>
          <se:Description>
            <se:Title>&lt;25%</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:And>
                <ogc:Not>
                  <ogc:PropertyIsNull>
                    <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  </ogc:PropertyIsNull>
                </ogc:Not>
                <ogc:PropertyIsNotEqualTo>
                  <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                  <ogc:Literal></ogc:Literal>
                </ogc:PropertyIsNotEqualTo>
              </ogc:And>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>andel_t_mag_proc</ogc:PropertyName>
                <ogc:Literal>25</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#0000ff</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.25</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
