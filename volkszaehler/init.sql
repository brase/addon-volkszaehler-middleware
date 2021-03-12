CREATE DATABASE `volkszaehler`;

CREATE USER 'vz'@'%' IDENTIFIED BY 'demo';

GRANT select, update, insert ON volkszaehler.* TO 'vz'@'%';