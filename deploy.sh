echo "BUILD AND START MICROSERVICES"
build() {
    cd ..
    cd $1
    ./mvnw package -DskipTests
}

build_gradlew() {
    ./gradlew build -x test
}

run_maven() {
    ./mvnw spring-boot:run
}

raun_gradlew() {
    ./gradlew bootRun
}

start_services() {
    cd ..
    pm2 start ecosystem.config.js
    echo "Strapi Api:  http://142.44.243.204:8085/"
 }

# Step 1:  BUILD 
cd api
./mvnw package -DskipTests

# Step 2: START 
start_services



