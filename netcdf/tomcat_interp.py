#interpolate snow depth and get it onto the tomcat grid
import iris
import numpy as np
import netCDF4 as nc
import os
#import geopy.distance as gd

snow_depth = iris.load('snow_depth_1.nc')[0].data
lat = iris.load('latitude.nc')[0].data
lon = iris.load('longitude.nc')[0].data

#tomcat lat and lon

tomcat_lat = [87.86, 85.10, 82.31, 79.53, 76.74,
        73.95, 71.16, 68.37, 65.58, 62.79,
        60.00, 57.21, 54.42, 51.63, 48.84,
        46.04, 43.25, 40.46, 37.67, 34.88,
        32.09, 29.30, 26.51, 23.72, 20.93,
        18.14, 15.35, 12.56,  9.77,  6.98,
         4.19,  1.40, -1.40, -4.19, -6.98,
        -9.77,-12.56,-15.35,-18.14,-20.93,
       -23.72,-26.51,-29.30,-32.09,-34.88,
       -37.67,-40.46,-43.25,-46.04,-48.84,
       -51.63,-54.42,-57.21,-60.00,-62.79,
       -65.58,-68.37,-71.16,-73.95,-76.74,
       -79.53,-82.31,-85.10,-87.86]

tomcat_lon_360 = np.arange(0,360,2.8125)

tomcat_lon = []
new_lon = 0

for i in range(len(tomcat_lon_360)):
    if tomcat_lon_360[i] > 180:
        new_lon = tomcat_lon_360[i]-360
    else:
        new_lon = tomcat_lon_360[i]
    tomcat_lon = np.append(tomcat_lon,new_lon)

tomcat_lon = np.sort(tomcat_lon)


########### snow depth regridding

new_snow_depth = np.zeros((12,130321,130321))
#a = '130321'
lat_1d = lat.flatten()
lon_1d = lon.flatten()

for k in range(12):
    print('value of k = ', k)
    snow_depth_1d = snow_depth[k,:,:].flatten()
    for i in range(130321):
    #for j in range(722):
        new_snow_depth[k,i,i] = snow_depth_1d[i]

print('sorted arrays before')
new_snow_depth_2 = np.sort(new_snow_depth, axis = 1)
new_snow_depth_3 = np.sort(new_snow_depth_2, axis = 2)
print('sorted arrays after')

#snow_depth_1d.shape

fn = 'snow_depth_regrid.nc'

#os.remove(fn)
ds = nc.Dataset(fn,'w',format = 'NETCDF4')

time = ds.createDimension('time',12)
lat_dim = ds.createDimension('unknown1',130321)
lon_dim = ds.createDimension('unknown2',130321)

temp_time = np.arange(1,13,1)
temp_lat = np.linspace(1,2,130321)
temp_lon = np.linspace(1,2,130321)
np.shape(temp_time)

times = ds.createVariable('time', 'f4', ('time',))
lats = ds.createVariable('unknown1', 'f4', ('unknown1',))
lons = ds.createVariable('unknown2', 'f4', ('unknown2',))
value = ds.createVariable('snow_depth', 'f4', ('time', 'unknown1', 'unknown2',))
value.units = 'm'

lats[:]=temp_lat
lons[:]=temp_lon
times[:]= temp_time

value[:,:,:] = new_snow_depth_3
ds.close()

cube111 = iris.load(fn)
cube111
