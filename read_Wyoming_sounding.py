def read_Wyoming_sounding(filename):
  import os
  import numpy as np
  st = os.stat(filename)  
  file_size = st.st_size 
  f = open(filename, 'r')
  temp1 = f.readline()
  temp1 = temp1.replace('\n','')
  temp2 = temp1.split(" ")
  nr = int(temp2[0])
  if(len(temp2) == 9):
    name = temp2[2]
    temp3 = temp2[5]
    hour = int(temp3[0:2])
    day = int(temp2[6])
    month = temp2[7]
    year = int(temp2[8])
  else:  
    name = temp2[1]
    temp3 = temp2[4]
    hour = int(temp3[0:2])
    day = int(temp2[5])
    month = temp2[6]
    year = int(temp2[7])
  temp1 = f.readline() # empty line
  temp1 = f.readline() # -----------------
  temp1 = f.readline()
  temp1 = temp1.replace('\n','')
  vars = temp1.split()
  temp1 = f.readline()
  units = temp1.split()   
  temp1 = f.readline() # -----------------                 
  pres = []
  hght = []
  temp = []
  dwpt = []
  rh = []
  mr = []
  wd = []
  ws = []  # in m/s
  thta = []
  thte = []
  thtv = []
  eof = False
  while eof == False:
    line = f.readline()
    line = line.replace('\n','')
    pres_temp = line[0:8].strip()
    if(len(pres_temp) > 0):
      pres_temp = float(pres_temp)
    else:
      pres_temp = np.nan
    pres.append(pres_temp)
    hght_temp = line[9:15].strip()
    if(len(hght_temp) > 0):
      hght_temp = int(hght_temp)
    else:
      hght_temp = np.nan
    hght.append(hght_temp)
    temp_temp = line[16:21].strip()
    if(len(temp_temp) > 0):
      temp_temp = float(temp_temp) + 273.15
    else:
      temp_temp = np.nan  
    temp.append(temp_temp)
    dwpt_temp = line[23:28].strip()
    if(len(dwpt_temp) > 0):
      dwpt_temp = float(dwpt_temp) + 273.15
    else:
      dwpt_temp = np.nan  
    dwpt.append(dwpt_temp)
    rh_temp = line[32:35].strip()
    if(len(rh_temp) > 0):
      rh_temp = float(rh_temp)
    else:
      rh_temp = np.nan  
    rh.append(rh_temp)
    mr_temp = line[36:42].strip()
    if(len(mr_temp) > 0):
      mr_temp = float(mr_temp) / 1000.0 # g/kg -> kg/kg
    else:
      mr_temp = np.nan  
    mr.append(mr_temp)
    wd_temp = line[43:49].strip()
    if(len(wd_temp) > 0):
      wd_temp = float(wd_temp)
    else:
      wd_temp = np.nan  
    wd.append(wd_temp)
    ws_temp = line[50:56].strip()
    if(len(ws_temp) > 0):
      ws_temp = float(ws_temp)
    else:
      ws_temp = np.nan  
    ws.append(ws_temp * 0.51444) # knt -> m/s
    thta_temp = line[57:63].strip()
    if(len(thta_temp) > 0):
      thta_temp = float(thta_temp)
    else:
      thta_temp = np.nan
    thta.append(thta_temp)
    thte_temp = line[64:70].strip()
    if(len(thte_temp) > 0):
      thte_temp = float(thte_temp)
    else:
      thte_temp = np.nan
    thte.append(thte_temp)
    thtv_temp = line[71:77].strip()
    if(len(thtv_temp) > 0):
      thtv_temp = float(thtv_temp)
    else:
      thtv_temp = np.nan
    thtv.append(thtv_temp)
    if f.tell() == file_size:
      eof = True
  f.close()
  res =  {'pres': pres, 'hght': hght, 'temp': temp, 'dwpt': dwpt, 'rh': rh, 'mr': mr, 'wd': wd, \
    'ws': ws, 'thta': thta, 'thte': thte, 'thtv': thtv}
  return res  


#10393 Lindenberg Observations at 12Z 28 Jul 2018
#
#-----------------------------------------------------------------------------
#   PRES   HGHT   TEMP   DWPT   RELH   MIXR   DRCT   SKNT   THTA   THTE   THTV
#    hPa     m      C      C      %    g/kg    deg   knot     K      K      K 
#-----------------------------------------------------------------------------
# 1000.0     79                                                               
#  996.0    112   29.4   17.4     48  12.71    110      6  302.9  340.8  305.2
#  977.0    283   25.6   15.6     54  11.53    117      8  300.7  334.9  302.8
#  934.0    678   21.8   15.1     66  11.69    135     12  300.8  335.4  302.9
#  925.0    763   21.0   15.0     69  11.72    130     14  300.8  335.5  302.9
#  915.0    856   20.1   14.8     71  11.66    130     14  300.8  335.3  302.9
#  896.0   1036   18.4   14.2     77  11.53    100     12  300.9  335.0  302.9
#  868.0   1309   15.8   13.5     86  11.33    115     12  300.9  334.5  302.9
#  854.0   1448   14.5   13.1     91  11.23    150     14  300.9  334.2  302.9
#  853.0   1458   14.4   13.1     92  11.23    150     14  300.9  334.2  302.9
#  850.0   1488   14.4   12.5     88  10.82    150     14  301.2  333.4  303.2


def interpolate_to_xhPa(res, dhPa):
  import numpy as np
  keys = res.keys()  
  min_press = min(res['pres'])
  max_press = max(res['pres'])
  nz = int(((max_press - min_press) / dhPa)+1)
  iz = 0
  keys = ['pres', 'hght', 'temp', 'dwpt', 'rh',  'mr', 'wd', 'ws', 'thta', 'thte', 'thtv']
  n_keys = len(keys)
  res2 = {'pres': [], 'hght': [], 'temp': [], 'dwpt': [], 'rh': [], 'mr': [], 'wd': [], 'ws': [], \
          'thta': [], 'thte': [], 'thtv': []}
  for i in range(0, nz):
    rec_press = max_press - float(i) * dhPa
    res2['pres'].append(rec_press)
    found = False
    while(found == False):
      if((res['pres'][iz] >= rec_press) and (res['pres'][iz+1] < rec_press)):
        found = True
        h1 = np.log(res['pres'][iz])
        h2 = np.log(res['pres'][iz+1])
        dh = h2 - h1 
        for i_keys in range(1, n_keys):
          if((np.isnan(res[keys[i_keys]][iz]) == False) and (np.isnan(res[keys[i_keys]][iz+1]) == False)):
            d_val = res[keys[i_keys]][iz+1] - res[keys[i_keys]][iz]
            grad_val = d_val / dh
            res_temp = res[keys[i_keys]][iz] + (np.log(rec_press) - h1)*grad_val 
            res2[keys[i_keys]].append(res_temp)
          else:
            res2[keys[i_keys]].append(np.nan)
      else:
        iz = iz + 1  
  return res2
  
def skip_missing_values(res):
  import numpy as np
  nz = len(res['pres'])
  keys = ['pres', 'hght', 'temp', 'dwpt', 'rh',  'mr', 'wd', 'ws', 'thta', 'thte', 'thtv']
  n_keys = len(keys)
  test_keys = ['temp', 'dwpt', 'mr'] #['press', 'hght', 'temp', 'dwpt', 'rh',  'mr', 'wd', 'ws', 'thta', 'thte', 'thtv']
  n_test_keys = len(test_keys)
  res2 = {'pres': [], 'hght': [], 'temp': [], 'dwpt': [], 'rh': [], 'mr': [], 'wd': [], 'ws': [], \
          'thta': [], 'thte': [], 'thtv': []}
  for i in range(0, nz):
    n_nan = 0  
    for i_test_keys in range(0, n_test_keys):
      if(np.isnan(res[test_keys[i_test_keys]][i]) == True):
        n_nan = n_nan + 1
    if(n_nan == 0):
      for i_keys in range(0, n_keys):
        res2[keys[i_keys]].append(res[keys[i_keys]][i])
  return res2

def add_specific_humidity(res):
  from Convective_Indexes import specific_humidity_from_mixing_ratio      
  nz = len(res['pres'])
  spec_hum_test = []
  for i in range(0, nz):
    sp = specific_humidity_from_mixing_ratio(res['mr'][i], res['pres'][i])  
    spec_hum_test.append(sp)
 
  res['spec_hum'] = spec_hum_test  
  return res  
  



