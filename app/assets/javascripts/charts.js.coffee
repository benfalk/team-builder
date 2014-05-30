jQuery ->

  data = {
    labels : ["Support","Carry","Top","Jungle","Mid"],
    datasets : [
      {
        fillColor : "rgba(223, 105, 26, 0.2)",
        strokeColor : "rgba(223, 105, 26, 0.8)",
        pointColor : "rgba(223, 105, 26, 1)",
        pointStrokeColor : "#fff",
        data : [65,59,90,81,43]
      }
    ]
  }
  options = {
    pointDotRadius : 3,
    pointDotStrokeWidth : 1,
    datasetStrokeWidth : 1,
    angleLineColor : "rgba(255,255,255,.2)",
    scaleLineColor : "rgba(255,255,255,.2)",
    pointLabelFontSize : 11,
    pointLabelFontColor : "#fff"
  }

  myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Radar(data,options) if $("#canvas").get(0)

