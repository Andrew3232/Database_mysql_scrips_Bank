USE `oleinych_a`;

drop index Phone on Banks;
drop index Post on `Position`;
drop index Non_ed on Education_type;

CREATE INDEX Phone ON Banks(Bank_phone);
CREATE INDEX Post ON `Position`(position_name);
CREATE INDEX Non_ed ON Education_type(Ed_type_name);

create or replace view Bank_name_by_phone_number as
	select id_banks as "id", Bank_name 
from Banks
    where Bank_phone = "380963276781";

create or replace view People_be_Cashier as
	select concat_ws(" ", pe.Fname, pe.Mname, pe.Lname) as FIO, position_name
	from Person pe inner join Worker w
		on pe.id_person = w.id_person
		inner join Position po on po.id_position = w.id_position
    where po.position_name = "Сashier";

create or replace view Client_no_education as
 	select concat_ws(" ", pe.Fname, pe.Mname, pe.Lname) as FIO, Ed_type_name as "Образования"
	from Person pe inner join Client c on pe.id_person = c.id_person
		inner join Education ed on c.id_education = ed.id_education
		inner join Education_type edt  on edt.id_education_type = ed.id_education_type
    where edt.Ed_type_name = "no education";

---

create or replace view count_Client_Ended_Donnu as
  	select count(c.id_client) as Ended_Donnu 
	from Client c inner join Education ed 
		on c.id_education = ed.id_education
	where ed.Ed_name_place = "Donnu"
	group by ed.id_education;

create or replace view Num_workers_on_post as
	select p.id_position, p.position_name, count(w.id_worker)
	from Worker w right join Position p 
		on p.id_position = w.id_position
	group by p.id_position, p.position_name;

create or replace view Num_credit_of_client as
	select c.id_client, count(ch.id_credit_history) as Количество_кредитов
	from Client c left join Credit_history ch
		on ch.id_credit_history = c.id_credit_history
	group by ch.id_credit_history, c.id_client;

---

create or replace view Sum_loan_more_average as
	select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO, ch.sum_loan
	from Person p inner join Client c 
		on c.id_Person = p.id_Person
		inner join Credit_history ch 
		on c.id_Credit_history = ch.id_Credit_history 
	where ch.sum_loan > 
	(select avg(ch2.sum_loan)
		from Credit_history ch2);
	
create or replace view Client_study_VNMU as
	select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO
	from Person p 
	where p.id_Person in 
	(select c.id_Person
		from Education e left join Client c 
			on c.id_Education = e.id_Education
		where e.Ed_name_place like "%VNMU%");

create or replace view Worker_who_are_clients as
	select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO
  	from Person p right join Client c 
    	on c.id_Person = p.id_Person
  	where p.id_Person in 
  	(select w.id_Person
    	from Worker w);