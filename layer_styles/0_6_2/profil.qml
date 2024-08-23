<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" styleCategories="AllStyleCategories" minScale="1e+8" hasScaleBasedVisibilityFlag="0" version="3.12.3-București" maxScale="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <customproperties>
    <property key="dualview/previewExpressions">
      <value>pkuid</value>
      <value>"pkuid"</value>
    </property>
    <property value="0" key="embeddedWidgets/count"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <geometryOptions removeDuplicateNodes="0" geometryPrecision="0">
    <activeChecks/>
    <checkConfiguration/>
  </geometryOptions>
  <referencedLayers/>
  <referencingLayers/>
  <fieldConfiguration>
    <field name="pkuid">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="profillinje">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="namn">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="projekt">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="QString" value="" name="FilterExpression"/>
            <Option type="QString" value="pkuid" name="Key"/>
            <Option type="QString" value="zz_projekt_be13623d_0a15_4e2a_b334_62ea933b32fd" name="Layer"/>
            <Option type="QString" value="zz_projekt" name="LayerName"/>
            <Option type="QString" value="spatialite" name="LayerProviderName"/>
            <Option type="QString" value="dbname=&quot;/home/henrik/temp/midv_tolkndb5.sqlite&quot; table=&quot;zz_projekt&quot;" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="true" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="namn" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="rapportnamn">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="kommentar">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="path">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="updated">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" name="" field="pkuid"/>
    <alias index="1" name="" field="profillinje"/>
    <alias index="2" name="" field="namn"/>
    <alias index="3" name="" field="projekt"/>
    <alias index="4" name="" field="rapportnamn"/>
    <alias index="5" name="" field="kommentar"/>
    <alias index="6" name="" field="path"/>
    <alias index="7" name="" field="updated"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default field="pkuid" applyOnUpdate="0" expression=""/>
    <default field="profillinje" applyOnUpdate="0" expression=""/>
    <default field="namn" applyOnUpdate="0" expression=""/>
    <default field="projekt" applyOnUpdate="0" expression=""/>
    <default field="rapportnamn" applyOnUpdate="0" expression=""/>
    <default field="kommentar" applyOnUpdate="0" expression=""/>
    <default field="path" applyOnUpdate="0" expression=""/>
    <default field="updated" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" constraints="3" unique_strength="1" field="pkuid" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="1" unique_strength="0" field="profillinje" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="1" unique_strength="0" field="namn" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" field="projekt" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" field="rapportnamn" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" field="kommentar" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="1" unique_strength="0" field="path" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" field="updated" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="pkuid"/>
    <constraint exp="" desc="" field="profillinje"/>
    <constraint exp="" desc="" field="namn"/>
    <constraint exp="" desc="" field="projekt"/>
    <constraint exp="" desc="" field="rapportnamn"/>
    <constraint exp="" desc="" field="kommentar"/>
    <constraint exp="" desc="" field="path"/>
    <constraint exp="" desc="" field="updated"/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
    <columns>
      <column width="-1" hidden="0" type="field" name="pkuid"/>
      <column width="-1" hidden="0" type="field" name="profillinje"/>
      <column width="-1" hidden="0" type="field" name="namn"/>
      <column width="-1" hidden="0" type="field" name="projekt"/>
      <column width="-1" hidden="0" type="field" name="rapportnamn"/>
      <column width="-1" hidden="0" type="field" name="kommentar"/>
      <column width="-1" hidden="0" type="field" name="path"/>
      <column width="-1" hidden="0" type="field" name="updated"/>
      <column width="-1" hidden="1" type="actions"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS formulär kan ha en Pythonfunktion som anropas när formuläret öppnas.

Använd denna funktion för att lägga till extra logik till dina formulär.

Skriv in namnet på funktionen i fältet "Python Init function".
Ett exempel nedan:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
	geom = feature.geometry()
	control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field editable="1" name="kommentar"/>
    <field editable="1" name="namn"/>
    <field editable="1" name="path"/>
    <field editable="0" name="pkuid"/>
    <field editable="1" name="profillinje"/>
    <field editable="1" name="projekt"/>
    <field editable="1" name="rapportnamn"/>
    <field editable="1" name="updated"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="kommentar"/>
    <field labelOnTop="0" name="namn"/>
    <field labelOnTop="0" name="path"/>
    <field labelOnTop="0" name="pkuid"/>
    <field labelOnTop="0" name="profillinje"/>
    <field labelOnTop="0" name="projekt"/>
    <field labelOnTop="0" name="rapportnamn"/>
    <field labelOnTop="0" name="updated"/>
  </labelOnTop>
  <widgets/>
  <previewExpression>pkuid</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>
