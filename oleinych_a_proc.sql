USE `oleinych_a`;

DELIMITER //

drop procedure if exists Bank_name_by_phone_number//

create procedure Bank_name_by_phone_number(in b_phone VARCHAR(14)) 
begin
	select id_banks as "id", Bank_name 
		from Banks
   		where Bank_phone like b_phone;
end//

drop procedure if exists People_be_Cashier//

create procedure People_be_Cashier(in Doljnost VARCHAR(64)) 
begin
	select concat_ws(" ", pe.Fname, pe.Mname, pe.Lname) as FIO, position_name
	from Person pe inner join Worker w
		on pe.id_person = w.id_person
		inner join Position po on po.id_position = w.id_position
    where po.position_name like Doljnost;
end//

drop procedure if exists Client_no_education;//

create procedure Client_no_education(in no_ed VARCHAR(64))
begin
 	select concat_ws(" ", pe.Fname, pe.Mname, pe.Lname) as FIO, Ed_type_name as "Образование"
	from Person pe inner join Client c on pe.id_person = c.id_person
		inner join Education ed on c.id_education = ed.id_education
		inner join Education_type edt  on edt.id_education_type = ed.id_education_type
    where edt.Ed_type_name like no_ed;
end//

---

drop procedure if exists count_Client_Ended_Donnu//

create procedure count_Client_Ended_Donnu(in ed_Donnu VARCHAR(64))
begin
  	select count(c.id_client) as Ended_Donnu 
	from Client c inner join Education ed 
		on c.id_education = ed.id_education
	where ed.Ed_name_place like ed_Donnu
	group by ed.id_education;
end//

drop procedure if exists Num_workers_on_post//

create procedure Num_workers_on_post(in count_work_on_post INT)
begin
	select p.id_position, p.position_name, count(w.id_worker)
	from Worker w right join Position p 
		on p.id_position = w.id_position
	group by p.id_position, p.position_name
	limit count_work_on_post;
end//

drop procedure if exists Num_credit_of_client//

create procedure Num_credit_of_client(in F_name VARCHAR(64), in Name VARCHAR(64))
begin
	select c.id_client, p.Fname, p.Mname, count(ch.id_credit_history) as Количество_кредитов
	from Person p inner join Client c
	on p.id_person = c.id_person
	left join Credit_history ch
		on ch.id_credit_history = c.id_credit_history
	where p.Fname like F_name and p.Mname like Name 
	group by ch.id_credit_history, c.id_client;
end//

---

drop procedure if exists Sum_loan_more_average//

create procedure Sum_loan_more_average(in loan_count INT)
begin
	select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO, ch.sum_loan
	from Person p inner join Client c 
		on c.id_Person = p.id_Person
		inner join Credit_history ch 
		on c.id_Credit_history = ch.id_Credit_history 
	where ch.sum_loan > 
	(select avg(ch2.sum_loan)
		from Credit_history ch2)
	limit loan_count;
end//

drop procedure if exists Client_study_VNMU//

create procedure Client_study_VNMU(in study_ed VARCHAR(64))
begin
	select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO
	from Person p 
	where p.id_Person in 
	(select c.id_Person
		from Education e left join Client c 
			on c.id_Education = e.id_Education
		where e.Ed_name_place like study_ed);
end//

drop procedure if exists Worker_who_are_clients//

create procedure Worker_who_are_clients(in F_name VARCHAR(64), in Name VARCHAR(64))
begin
	select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO
  	from Person p right join Client c 
    	on c.id_Person = p.id_Person
  	where p.id_Person in 
  	(select w.id_Person
    	from Worker w
    	where p.Fname like F_name and p.Mname like Name);
end//

