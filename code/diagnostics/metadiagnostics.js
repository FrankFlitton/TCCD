
      var progressChart = c3.generate({
      bindto: '#progressChart',
      data: {
      x: 'x',
      columns: [
      ['x','2017-02-23', '2017-01-25', '2017-02-01', '2017-03-14', '2017-01-18', '2017-03-24', '2017-03-30', '2017-01-30', '2017-01-19', '2017-07-05', '2017-06-30', '2017-02-16', '2017-01-10', '2017-04-25', '2017-04-07', '2017-03-27', '2017-04-04', '2017-08-30', '2017-03-21', '2017-03-22', '2017-08-23', '2017-03-08', '2017-06-28', '2017-04-13', '2017-01-17', '2017-08-15', '2017-03-03', '2017-08-21', '2017-03-31', '2017-02-08', '2017-06-09', '2017-04-05', '2017-08-24', '2017-06-26', '2017-09-11', '2017-03-29', '2017-06-21', '2017-02-21', '2017-05-24', '2017-04-19', '2017-02-22', '2017-02-27'],
      ['Original scanned pages', 7648, 7648, 7648, 7648, 7648, 7648, 7648, 7648, 7648, 7961, 7961, 7648, 7648, 7648, 7648, 7648, 7648, 9353, 7648, 7648, 7961, 7648, 7650, 7648, 7239, 7961, 7648, 7961, 7648, 7648, 7650, 7648, 8662, 7650, 9353, 7648, 7650, 7648, 7648, 7648, 7648, 7648],
      ['Edited HOCR pages', 2697, 2197, 2389, 2697, 2110, 2697, 2697, 2282, 2110, 2781, 2781, 2697, 1787, 2697, 2697, 2697, 2697, 2781, 2697, 2697, 2781, 2697, 2697, 2697, 1873, 2781, 2697, 2781, 2697, 2608, 2697, 2697, 2781, 2697, 2781, 2697, 2697, 2697, 2697, 2697, 2697, 2697],
      ['Pages in TEI', 1154, 900, 900, 1531, 852, 1798, 1798, 900, 852, 2296, 2292, 1026, 810, 1921, 1798, 1798, 1798, 2917, 1708, 1749, 2916, 1341, 2271, 1823, 852, 2749, 1226, 2916, 1798, 963, 2016, 1798, 2917, 2224, 2961, 1798, 2176, 1120, 1946, 1832, 1120, 1154],
      ['Pages in TEI with names tagged', 828, 641, 641, 1184, 622, 1505, 1644, 641, 622, 2215, 2211, 828, 605, 1840, 1663, 1644, 1663, 2841, 1268, 1505, 2840, 995, 2190, 1688, 622, 2673, 901, 2840, 1644, 710, 1921, 1663, 2841, 2143, 2885, 1644, 2095, 828, 1865, 1697, 828, 828]
        ],
      axes: {
        data1: 'y',
        data1: 'y2'
      }
      
      },
      axis: {
        x: {
          type: 'timeseries',
          tick: {
          fit: true,
          culling: false,
          rotate: 90,
          format: '%Y-%m-%d'
        }
      },
      y: {
        label: {
          text: 'Pages',
          position: 'outer-middle'
        },
        tick:{
          outer: false,
          min: 0,
          max: 10000,
          format: d3.format('d')
        }
      },
      y2: {
        show: true,
        tick:{
          format: d3.format('.0%')
        }
      }
    },
    padding: {
    right: 100,
    left: 75
    }
    });
      