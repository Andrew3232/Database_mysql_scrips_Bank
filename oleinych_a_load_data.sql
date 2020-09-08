USE `oleinych_a`;

INSERT INTO `Person` (`Fname`,`Mname`,`Lname`,`date_of_birth`) VALUES
  	("Ivanov", 		  "Ivan", 	   "Ivan", 		       	19970520),
  	("Karazin", 	  "Oleg", 	   "Sergiyovich", 	  19890304),
  	("Rovin",	      "Igor", 	   "Victorovich", 	  19970707),
  	("Benko", 		  "Pavlo", 	   "Volodumurovich", 	19900505),
  	("Bevz", 		    "Ivan", 	   "Yuriyouvich",	   	19901124),
  	("Kovalchuk",   "Evgeniny",  "Artemovich",	    19910929),
  	("Divenko", 	  "Pavlo", 	   "Mikolayouvich",	  19941218),
  	("Olin", 		    "Andriy",	   "Alexandrovich",	  19940112)
;

INSERT INTO `address` (`city`,`address`) VALUES
  	("Vinnytsia",    "st. Keletska 30"),
  	("Kiev",         "st. Kosmonavtiv 49"),
  	("Moscow",       "st. Litvunenka 13"),
  	("Keiv",         "st. Soborna 43"),
  	("Vinnytsia",    "st. Kievska 17"),
  	("Vinnytsia",    "st. 600-richya 21"),
  	("Vinnytsia",    "st. Shevchenka 36"),
  	("Vinnytsia",    "st. 600-richya 72"),
  	("Vinnytsia",    "st. Kosmonavtiv 63"),
  	("Vinnytsia",    "st. Bloka 21")
;

INSERT INTO `Work_place` (`WP_name`,`id_address`,`WP_phone`) VALUES
  	("Silpo", 			  1, 	"380683436393"),
  	("Chillipizza", 	2,  "380673435393"),
  	("Zolotiy vik", 	3,  "380983456363"),
  	("Everest", 		  4,  "380669735393"),
  	("Barbershop", 		5,  "380993778663"),
    ("Privatbank",    6,  "380994576585")
;

INSERT INTO `Education_type` (`Ed_type_name`) VALUES
  	("higher education"),
  	("secondary education"),
  	("no education")
;

INSERT INTO `Education` (`Ed_name_place`,`id_education_type`) VALUES
  	("Donnu", 	1),
  	("KPI", 	  1),
  	("", 		    3),
  	("VNMU",   	1),
  	("VPK", 	  2)
;

INSERT INTO `Banks` (`Bank_name`,`id_address`,`Bank_phone`) VALUES
  	("Privatbank",	 6,	 "380994576585"),
  	("Alfabank", 	   7,  "380963276781"),
  	("Monobank", 	   8,  "380501345777")
;

INSERT INTO `Credit_history` (`id_banks`,`sum_loan`,`quality_of_payment`) VALUES
  	(1,	   10000,  10),
  	(3,    30000,   8),
  	(2,    50000,   9),
  	(1,    45000,   4),
  	(3,   100000,   7)
;

INSERT INTO `Position` (`position_name`) VALUES
  	("Сashier"),
  	("Operator"),
  	("Manager"),
  	("Builder"),
  	("Waiter"),
  	("lawyer")
;

INSERT INTO `Client` (`id_person`,`id_address`,`phone number`,`id_education`,`id_work_place`,`average_salary`,`id_credit_history`,`id_position`) VALUES
  	(1,   9,  "380961222202",  1,  2,   6500,  1,  5),
  	(2,  10,  "380961224406",  1,  1,   4500,  2,  1),
  	(3,   3,  "380668724621",  3,  5,  10000,  3,  3),
  	(4,   4,  "380673459861",  4,  4,   9500,  5,  6),
    (5,   6,  "380668724656",  5,  6,  15000,  4,  3)
;

INSERT INTO `Worker` (`id_person`,`id_banks`,`id_position`) VALUES
  	(5,  1,  3),
  	(6,  3,  2),
  	(8,  2,  1),
  	(7,  1,  1)
;

INSERT INTO `date_of_making` (`date_begin`,`date_end`) VALUES
  	(20110314, 20140314),
  	(20180515, 20180715),
  	(20170623, 20180723),
  	(20151213, 20161213),
    (20151216, 20161216)
;

INSERT INTO `Credit_info` (`sum`,`id_date_of_making`,`Credit_num`,`id_worker`,`id_client`) VALUES
  	( 13500,   1,  12486430,  4,  1),
  	(190000,   2,  45323452,  1,  2),
  	( 15500,   3,  63785642,  3,  3),
  	(  6500,   4,  12355376,  4,  4),
    ( 15000,   5,  14365332,  2,  5)
;

INSERT INTO `Type_operation` (`operation_type`) VALUES
  	("issuance of credit"),
  	("loan repayment")
;

INSERT INTO `Payments` (`id_worker`,`sum_pay`,`date_pay`,`Credit_num`,`id_type_operation`) VALUES
  	(3,     60000,   20180615120003,  45323452,  2),
  	(3,     30000,   20180710201813,  45323452,  2),
  	(4,     13500,   20110314173515,  12486430,  1),
  	(4,     15500,   20170623091743,  63785642,  1),
  	(2,      5000,   20151223101010,  12355376,  2)
 ;
