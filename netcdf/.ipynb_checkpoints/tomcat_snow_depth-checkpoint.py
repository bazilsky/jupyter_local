import numpy as np
import iris
import numpy as np
from geopy.distance import geodesic as GD
import time
import netCDF4 as nc
import os



def main():
    snow_depth = iris.load('snow_depth_1.nc')[0].data
    lat = iris.load('latitude.nc')[0].data
    lon = iris.load('longitude.nc')[0].data

    #tomcat lat and lon

    tomcat_lat = np.array([87.86, 85.10, 82.31, 79.53, 76.74,
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
           -79.53,-82.31,-85.10,-87.86])

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


    lat_1d = lat.flatten()
    lon_1d = lon.flatten()
    dist_arr = np.array([])

    tomcat_lat_arctic = tomcat_lat[tomcat_lat>60]
    point_arr = []
    point_index_arr = []

    for i in range(len(tomcat_lat_arctic)):
        for j in range(len(tomcat_lon)):

            point = (tomcat_lat_arctic[i],tomcat_lon[j])
            point_index = (i,j)

            point_arr.append(point)
            point_index_arr.append(point_index)

    tomcat_snow_depth = np.zeros((12,len(tomcat_lat),len(tomcat_lon)))

    import time
    time1 = time.time()

    for k in range(len(point_arr)):
    #for k in range(1): # testing just one array value
        print('value of k = ',k)
        point2 = point_arr[k] # this k value has a certain i and j corresponding to tomcat array
        dist_arr = []
        for i in range(len(lat_1d)):
            point1 = (lat_1d[i], lon_1d[i])
            #point2 = (tomcat_lat_arctic[0], tomcat_lon[0])
            dist = GD(point1,point2).km
            dist_arr = np.append(dist_arr,dist)
        index = np.argmin(dist_arr)
        reverse_index = (int(index/361),i%361)
        print('point_index_arr[k][i], point_index_arr[k][j] = ', point_index_arr[k][0], point_index_arr[k][1])
        print('reverse_index[0],reverse_index[1] = ', reverse_index[0],reverse_index[1])
        tomcat_snow_depth[:, point_index_arr[k][0], point_index_arr[k][1]] = snow_depth[:,reverse_index[0],reverse_index[1]]

    #snow_depth_tomcat =                                     # position in array with values int(i/361), i%361

    time2 = time.time()

    print('code time = ', time2 - time1)

    #save netcdf file of tomcat snow depth
    # save snow depth, latitude and longitude into a netcdf file

    fn = 'tomcat_now_depth_1.nc'

    os.remove(fn)
    ds = nc.Dataset(fn,'w',format = 'NETCDF4')

    time = ds.createDimension('time',12)
    lat_dim = ds.createDimension('lat',len(tomcat_lat))
    lon_dim = ds.createDimension('lon',len(tomcat_lon))

    temp_time = np.arange(1,13,1)
    temp_lat = np.linspace(1,2,len(tomcat_lat))
    temp_lon = np.linspace(1,2,len(tomcat_lon))
    np.shape(temp_time)

    times = ds.createVariable('time', 'f4', ('time',))
    lats = ds.createVariable('lat', 'f4', ('lat',))
    lons = ds.createVariable('lon', 'f4', ('lon',))
    value = ds.createVariable('snow_depth', 'f4', ('time', 'lat', 'lon',))
    value.units = 'm'

    lats[:]=temp_lat
    lons[:]=temp_lon
    times[:]= temp_time

    value[:,:,:] = tomcat_snow_depth
    ds.close()

    #cube111 = iris.load(fn)
    #cube111

if __name__ == '__main__':
    print('hello')
    main()
