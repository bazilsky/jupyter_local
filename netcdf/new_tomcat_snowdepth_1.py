import numpy as np
import iris
import time
import netCDF4 as nc

def haversine_distance(lat1, lon1, lat2, lon2):
    # Convert latitude and longitude from degrees to radians
    lat1, lon1, lat2, lon2 = np.radians([lat1, lon1, lat2, lon2])

    # Compute the difference between the latitudes and longitudes
    dlat = lat2 - lat1
    dlon = lon2 - lon1

    # Use the Haversine formula to compute the distance
    a = np.sin(dlat/2)**2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlon/2)**2
    c = 2 * np.arcsin(np.sqrt(a))

    # The Earth's radius, in kilometers
    R = 6371

    # Return the distance, in kilometers
    return c * R

def find_NN(point1):
    dist = np.zeros((361,361))
    for i in range(361):
        for j in range(0,361):
            point2 = (lat[i,j],lon[i,j])
            dist[i,j] = haversine_distance(point1[0],point1[1],point2[0],point2[1])
    min_index = np.argmin(dist)
    # i and j values where distance is minimum
    row = min_index // dist.shape[1]
    col = min_index % dist.shape[1]
    return row, col

def save_netcdf(data):
    fn = 'tomcat_snow_depth_2.nc'
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

    value[:,:,:] = data[:,:,:]
    ds.close()







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

tomcat_snow_depth = np.zeros((12,len(tomcat_lat),len(tomcat_lon)))

time1 = time.time()
#for i in range(2):
#    for j in range(2):
for i in range(len(tomcat_lat)):
    for j in range(len(tomcat_lon)):
        point1 = (tomcat_lat[i], tomcat_lon[j])
        row, col = find_NN(point1)
        tomcat_snow_depth[:,i,j] = snow_depth[:,row,col]
        if snow_depth[0,row,col] != 0:
            print('non zero value', i, j)


time2 = time.time()

print('Total time for main loop = ', time2 - time1)

save_netcdf(tomcat_snow_depth)
