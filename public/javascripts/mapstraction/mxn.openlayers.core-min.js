/*
Copyright (c) 2009 Tom Carden, Steve Coast, Mikel Maron, Andrew Turner, Henri Bergius, Rob Moran, Derek Fowler
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of the Mapstraction nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
mxn.register("openlayers",{Mapstraction:{init:function(a,b){var c=this;this.maps[b]=new OpenLayers.Map(a.id,{maxExtent:new OpenLayers.Bounds(-20037508.34,-20037508.34,20037508.34,20037508.34),maxResolution:156543,numZoomLevels:18,units:"meters",projection:"EPSG:41001"});this.layers.osmmapnik=new OpenLayers.Layer.TMS("OSM Mapnik",["http://a.tile.openstreetmap.org/","http://b.tile.openstreetmap.org/","http://c.tile.openstreetmap.org/"],{type:"png",getURL:function(h){var g=this.map.getResolution();var d=Math.round((h.left-this.maxExtent.left)/(g*this.tileSize.w));var k=Math.round((this.maxExtent.top-h.top)/(g*this.tileSize.h));var j=this.map.getZoom();var e=Math.pow(2,j);if(k<0||k>=e){return null}else{d=((d%e)+e)%e;var i=j+"/"+d+"/"+k+"."+this.type;var f=this.url;if(f instanceof Array){f=this.selectUrl(i,f)}return f+i}},displayOutsideMaxExtent:true});this.layers.osm=new OpenLayers.Layer.TMS("OSM",["http://a.tah.openstreetmap.org/Tiles/tile.php/","http://b.tah.openstreetmap.org/Tiles/tile.php/","http://c.tah.openstreetmap.org/Tiles/tile.php/"],{type:"png",getURL:function(h){var g=this.map.getResolution();var d=Math.round((h.left-this.maxExtent.left)/(g*this.tileSize.w));var k=Math.round((this.maxExtent.top-h.top)/(g*this.tileSize.h));var j=this.map.getZoom();var e=Math.pow(2,j);if(k<0||k>=e){return null}else{d=((d%e)+e)%e;var i=j+"/"+d+"/"+k+"."+this.type;var f=this.url;if(f instanceof Array){f=this.selectUrl(i,f)}return f+i}},displayOutsideMaxExtent:true});this.maps[b].addLayer(this.layers.osmmapnik);this.maps[b].addLayer(this.layers.osm);this.loaded[b]=true},applyOptions:function(){},resizeTo:function(b,a){this.currentElement.style.width=b;this.currentElement.style.height=a;this.maps[this.api].updateSize()},addControls:function(a){var c=this.maps[this.api];for(var b=c.controls.length;b>1;b--){c.controls[b-1].deactivate();c.removeControl(c.controls[b-1])}if(a.zoom=="large"){c.addControl(new OpenLayers.Control.PanZoomBar())}else{if(a.zoom=="small"){c.addControl(new OpenLayers.Control.ZoomPanel());if(a.pan){c.addControl(new OpenLayers.Control.PanPanel())}}else{if(a.pan){c.addControl(new OpenLayers.Control.PanPanel())}}}if(a.overview){c.addControl(new OpenLayers.Control.OverviewMap())}if(a.map_type){c.addControl(new OpenLayers.Control.LayerSwitcher())}},addSmallControls:function(){var a=this.maps[this.api];this.addControlsArgs.pan=false;this.addControlsArgs.scale=false;this.addControlsArgs.zoom="small";a.addControl(new OpenLayers.Control.ZoomBox());a.addControl(new OpenLayers.Control.LayerSwitcher({ascending:false}))},addLargeControls:function(){var a=this.maps[this.api];a.addControl(new OpenLayers.Control.PanZoomBar());this.addControlsArgs.pan=true;this.addControlsArgs.zoom="large"},addMapTypeControls:function(){var a=this.maps[this.api];a.addControl(new OpenLayers.Control.LayerSwitcher({ascending:false}));this.addControlsArgs.map_type=true},setCenterAndZoom:function(a,b){var d=this.maps[this.api];var c=a.toProprietary(this.api);d.setCenter(a.toProprietary(this.api),b)},addMarker:function(b,a){var d=this.maps[this.api];var c=b.toProprietary(this.api);if(!this.layers.markers){this.layers.markers=new OpenLayers.Layer.Markers("markers");d.addLayer(this.layers.markers)}this.layers.markers.addMarker(c);return c},removeMarker:function(a){var c=this.maps[this.api];var b=a.toProprietary(this.api);this.layers.markers.removeMarker(b);b.destroy()},removeAllMarkers:function(){var a=this.maps[this.api]},declutterMarkers:function(a){var b=this.maps[this.api]},addPolyline:function(b,a){var d=this.maps[this.api];var c=b.toProprietary(this.api);if(!this.layers.polylines){this.layers.polylines=new OpenLayers.Layer.Vector("polylines");d.addLayer(this.layers.polylines)}b.setChild(c);this.layers.polylines.addFeatures([c]);return c},removePolyline:function(a){var c=this.maps[this.api];var b=a.toProprietary(this.api);this.layers.polylines.removeFeatures([b])},removeAllPolylines:function(){var c=[];for(var a=0,b=this.polylines.length;a<b;a++){c.push(this.polylines[a].toProprietary(this.api))}if(this.layers.polylines){this.layers.polylines.removeFeatures(c)}},getCenter:function(){var a=this.maps[this.api];pt=a.getCenter();return new mxn.LatLonPoint(pt.lat,pt.lon)},setCenter:function(a,b){var d=this.maps[this.api];var c=a.toProprietary(this.api);d.setCenter(c)},setZoom:function(a){var b=this.maps[this.api];b.zoomTo(a)},getZoom:function(){var a=this.maps[this.api];return a.zoom},getZoomLevelForBoundingBox:function(b){var a=this.maps[this.api];return zoom},setMapType:function(a){var b=this.maps[this.api];throw"Not implemented (setMapType)"},getMapType:function(){var a=this.maps[this.api];return mxn.Mapstraction.ROAD},getBounds:function(){var b=this.maps[this.api];var a=b.calculateBounds();return new mxn.BoundingBox(a.bottom,a.left,a.top,a.right)},setBounds:function(c){var e=this.maps[this.api];var a=c.getSouthWest();var d=c.getNorthEast();if(a.lon>d.lon){a.lon-=360}var b=new OpenLayers.Bounds();b.extend(new mxn.LatLonPoint(a.lat,a.lon).toProprietary(this.api));b.extend(new mxn.LatLonPoint(d.lat,d.lon).toProprietary(this.api));e.zoomToExtent(b)},addImageOverlay:function(c,a,e,i,f,g,d,h){var b=this.maps[this.api]},setImagePosition:function(e,b){var d=this.maps[this.api];var c;var a},addOverlay:function(a,b){var c=this.maps[this.api]},addTileLayer:function(f,a,b,d,e){var c=this.maps[this.api]},toggleTileLayer:function(b){var a=this.maps[this.api]},getPixelRatio:function(){var a=this.maps[this.api]},mousePosition:function(a){var b=this.maps[this.api]}},LatLonPoint:{toProprietary:function(){var b=this.lon*20037508.34/180;var a=Math.log(Math.tan((90+this.lat)*Math.PI/360))/(Math.PI/180);a=a*20037508.34/180;return new OpenLayers.LonLat(b,a)},fromProprietary:function(a){var c=(a.lon/20037508.34)*180;var b=(a.lat/20037508.34)*180;b=180/Math.PI*(2*Math.atan(Math.exp(b*Math.PI/180))-Math.PI/2);this.lon=c;this.lat=b}},Marker:{toProprietary:function(){var e,d,f;if(this.iconSize){e=new OpenLayers.Size(this.iconSize[0],this.iconSize[1])}else{e=new OpenLayers.Size(21,25)}if(this.iconAnchor){d=new OpenLayers.Pixel(this.iconAnchor[0],this.iconAnchor[1])}else{d=new OpenLayers.Pixel(-(e.w/2),-e.h)}if(this.iconUrl){f=new OpenLayers.Icon(this.iconUrl,e,d)}else{f=new OpenLayers.Icon("http://openlayers.org/dev/img/marker-gold.png",e,d)}var b=new OpenLayers.Marker(this.location.toProprietary("openlayers"),f);if(this.infoBubble){var a=new OpenLayers.Popup(null,this.location.toProprietary("openlayers"),new OpenLayers.Size(100,100),this.infoBubble,true);a.autoSize=true;var c=this.map;if(this.hover){b.events.register("mouseover",b,function(h){c.addPopup(a);a.show()});b.events.register("mouseout",b,function(h){a.hide();c.removePopup(a)})}else{var g=false;b.events.register("mousedown",b,function(h){if(g){a.hide();c.removePopup(a);g=false}else{c.addPopup(a);a.show();g=true}})}}if(this.hoverIconUrl){}if(this.infoDiv){}return b},openBubble:function(){},hide:function(){this.proprietary_marker.setOptions({visible:false})},show:function(){this.proprietary_marker.setOptions({visible:true})},update:function(){}},Polyline:{toProprietary:function(){var f;var d=[];var a;var c={strokeColor:this.color||"#000000",strokeOpacity:this.opacity||1,strokeWidth:this.width||1,fillColor:this.fillColor||"#000000",fillOpacity:this.getAttribute("fillOpacity")||0.2};for(var b=0,e=this.points.length;b<e;b++){olpoint=this.points[b].toProprietary("openlayers");d.push(new OpenLayers.Geometry.Point(olpoint.lon,olpoint.lat))}if(this.closed){a=new OpenLayers.Geometry.LinearRing(d)}else{a=new OpenLayers.Geometry.LineString(d)}f=new OpenLayers.Feature.Vector(a,null,c);return f},show:function(){throw"Not implemented"},hide:function(){throw"Not implemented"}}});