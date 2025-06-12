// sweeping/static/js/map.js

// 初始化高德地图
function initMap() {
    var map = new AMap.Map('map', {
        zoom: 14,
        center: [116.397428, 39.90923] // 默认中心点（北京）
    });

    // 示例：添加车辆位置标记
    var vehicleMarker = new AMap.Marker({
        position: [116.397428, 39.90923],
        title: "车辆1",
        content: "<div>车辆1 - 电量: 80%</div>"
    });
    map.add(vehicleMarker);

    // 示例：绘制清扫线路
    var polyline = new AMap.Polyline({
        path: [
            [116.397428, 39.90923],
            [116.398428, 39.90923],
            [116.398428, 39.91023],
            [116.397428, 39.91023]
        ],
        strokeColor: "#ff3300",
        strokeWeight: 3,
        strokeStyle: "solid",
        strokeOpacity: 0.8
    });
    map.add(polyline);
}