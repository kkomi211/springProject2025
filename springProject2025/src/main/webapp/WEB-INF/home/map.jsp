<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vue + Tmap Route Example</title>

    <!-- Vue -->
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

    <!-- Tmap API -->
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=H9rOK0SDBL2JBlhmjYl6Z8eTS9ooxNHz4hwPSA7f"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        label {
            display: inline-block;
            width: 120px;
        }
        input {
            margin-bottom: 10px;
            padding: 4px;
            width: 200px;
        }
        button {
            margin-top: 15px;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
        }
        #result {
            font-size: 16px;
            margin-top: 20px;
            font-weight: bold;
        }
        #map_div {
            width: 100%;
            height: 400px;
        }
    </style>
</head>
<body>

<div id="app">

    <h2>Tmap 경로 탐색 (Vue + AJAX)</h2>

    <!-- 지도 영역 -->
    <div id="map_wrap">
        <div id="map_div"></div>
    </div>

    <!-- 입력 영역 -->
    <div style="margin-top:20px;">
        <h3>출발지 / 도착지 좌표 입력</h3>

        <div>
            <label>출발지 위도 (Y):</label>
            <input type="text" v-model="startY">
        </div>
        <div>
            <label>출발지 경도 (X):</label>
            <input type="text" v-model="startX">
        </div>

        <div style="margin-top:10px;">
            <label>도착지 위도 (Y):</label>
            <input type="text" v-model="endY">
        </div>
        <div>
            <label>도착지 경도 (X):</label>
            <input type="text" v-model="endX">
        </div>

        <button @click="fnSearchRoute">경로 찾기</button>
    </div>

    <div id="result"></div>

</div>

<script>
const app = Vue.createApp({
    data() {
        return {
            map: null,
            markerStart: null,
            markerEnd: null,
            resultLines: [],

            // 기본 좌표값
            // startX: "126.99696349525492",
            // startY: "37.561590999574236",
            // endX: "126.9956203528817",
            // endY: "37.56216145788358",

            startX: "",
            startY: "",
            endX: "",
            endY: "",
        }
    },

    methods: {
        /** 지도 초기화 */
        initMap() {
            this.map = new Tmapv2.Map("map_div", {
                center: new Tmapv2.LatLng(37.56259379, 126.99243652),
                width: "100%",
                height: "400px",
                zoom: 17
            });
        },

        /** 기존 경로/마커 삭제 */
        clearRoute() {
            this.resultLines.forEach(line => line.setMap(null));
            this.resultLines = [];

            if (this.markerStart) this.markerStart.setMap(null);
            if (this.markerEnd) this.markerEnd.setMap(null);
        },

        /** 경로 요청 실행 */
        fnSearchRoute() {
            let self = this;

            // 경로 초기화
            self.clearRoute();

            // 출발 마커
            self.markerStart = new Tmapv2.Marker({
                position: new Tmapv2.LatLng(self.startY, self.startX),
                map: self.map
            });

            // 도착 마커
            self.markerEnd = new Tmapv2.Marker({
                position: new Tmapv2.LatLng(self.endY, self.endX),
                map: self.map
            });

            // AJAX 요청
            $.ajax({
                type: "POST",
                url: "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json",
                headers: {
                    "Accept": "application/json",
                    "appKey": "H9rOK0SDBL2JBlhmjYl6Z8eTS9ooxNHz4hwPSA7f",
                    "Content-Type": "application/json"
                },
                data: JSON.stringify({
                    startX: self.startX,
                    startY: self.startY,
                    endX: self.endX,
                    endY: self.endY,
                    reqCoordType: "WGS84GEO",
                    resCoordType: "EPSG3857",
                    startName : "출발지",
					endName : "도착지"
                }),

                success: function (res) {
                    
                    let result = res.features;
                    let drawPoints = [];

                    // 총 거리 / 시간 표시
                    let tDistance = (result[0].properties.totalDistance / 1000).toFixed(1) + "km";
                    let tTime = (result[0].properties.totalTime / 60).toFixed(0) + "분";
                    $("#result").text("총 거리: " + tDistance + " | 총 시간: " + tTime);

                    // 경로 라인 만들기
                    result.forEach(item => {
                        if (item.geometry.type === "LineString") {
                            item.geometry.coordinates.forEach(coord => {
                                let point = new Tmapv2.Point(coord[0], coord[1]);
                                let convert = Tmapv2.Projection.convertEPSG3857ToWGS84GEO(point);
                                drawPoints.push(new Tmapv2.LatLng(convert._lat, convert._lng));
                            });
                        }
                    });

                    // polyline 생성
                    let line = new Tmapv2.Polyline({
                        path: drawPoints,
                        strokeColor: "#DD0000",
                        strokeWeight: 6,
                        map: self.map
                    });

                    self.resultLines.push(line);
                },

                error: function (xhr) {
                    console.error("경로 오류:", xhr.responseText);
                }
            });
        }
    },

    mounted() {
        this.initMap();
    }
});

app.mount("#app");
</script>

</body>
</html>
