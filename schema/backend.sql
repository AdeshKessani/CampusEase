CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(80) UNIQUE NOT NULL,
    email VARCHAR(140) UNIQUE NOT NULL
);

CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    room_name VARCHAR(80) NOT NULL,
    reserved BOOLEAN DEFAULT FALSE
);

CREATE TABLE seat_bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    room_id INT REFERENCES rooms(room_id),
    time_slot VARCHAR(40) NOT NULL
);
