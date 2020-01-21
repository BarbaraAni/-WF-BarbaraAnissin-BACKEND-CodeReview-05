-- returns all values from table User:
Select * FROM `users`;

-- returns selected 'user' from table User:
SELECT user_id, first_name, last_name FROM `users`;

-- returns user with the user first name 'Julia':
SELECT user_id FROM `users` WHERE first_name='Julia';

-- returns the last name 'Test':
SELECT user_id, first_name, last_name FROM `users` WHERE last_name='Test';

-- join car+returning:
SELECT end_date, seats
FROM `returning`
INNER JOIN `car`
ON returning.fk_car_id = car.car_id;

-- join reservation+user:
SELECT reservation_id, first_name, last_name
FROM `reservation`
INNER JOIN `users`
ON reservation.fk_user_id= users.user_id;