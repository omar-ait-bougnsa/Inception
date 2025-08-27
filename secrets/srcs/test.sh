# create directories used by driver_opts
sudo mkdir -p /home/sonkang/data/database /home/sonkang/data/wordpress

# give your user permissions (change 'omar' if different)
sudo chown -R omar:omar /home/sonkang/data
sudo chmod -R 0755 /home/sonkang/data

# then recreate containers
cd /home/omar/Desktop/Inception/secrets/srcs
docker-compose down -v
docker-compose up --build