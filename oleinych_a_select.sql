USE `oleinych_a`;

--
--- на выборку (обычные)
--

--- за номером телефона вывести название банка

select id_banks as "id", Bank_name 
from Banks
    where Bank_phone = "380963276781";


--- вывести сотрудников которые занимать должность "Сashier"

select concat_ws(" ", pe.Fname, pe.Mname, pe.Lname) as FIO, position_name
	from Person pe inner join Worker w
	on pe.id_person = w.id_person
	inner join Position po on po.id_position = w.id_position
    where po.position_name = "Сashier";

--- вывести клиентов без образования

select concat_ws(" ", pe.Fname, pe.Mname, pe.Lname) as FIO, Ed_type_name as "Образование"
	from Person pe inner join Client c on pe.id_person = c.id_person
		inner join Education ed on c.id_education = ed.id_education
		inner join Education_type edt  on edt.id_education_type = ed.id_education_type
    where edt.Ed_type_name = "no education";

--
--- агрегирующие
--

--- вывести количество Клиентов которые закончили ДонНУ

select count(c.id_client) as Ended_Donnu 
	from Client c inner join Education ed 
		on c.id_education = ed.id_education
	where ed.Ed_name_place = "Donnu"
	group by ed.id_education;

--- количество сотрудников на каждей из должностей

select p.id_position, p.position_name, count(w.id_worker)
	from Worker w right join Position p 
		on p.id_position = w.id_position
	group by p.id_position, p.position_name;

--- вывести человека и количество его кредитов

select c.id_client, count(ch.id_credit_history) as Количество_кредитов
	from Client c left join Credit_history ch
		on ch.id_credit_history = c.id_credit_history
	group by ch.id_credit_history, c.id_client;

--
--- вложенные
--

-- Отобрать людей, сумма выплаты которых больше среднего

select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO, ch.sum_loan
	from Person p inner join Client c 
		on c.id_Person = p.id_Person
		inner join Credit_history ch 
		on c.id_Credit_history = ch.id_Credit_history 
	where ch.sum_loan > 
	(select avg(ch2.sum_loan)
		from Credit_history ch2);

-- Отобрать людей, что учились в ВНМУ

select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO
	from Person p 
	where p.id_Person in 
	(select c.id_Person
		from Education e left join Client c 
			on c.id_Education = e.id_Education
		where e.Ed_name_place like "%VNMU%");

-- Отобрать клиентов, которые являються работниками банка

select concat_ws(" ", p.Fname, p.Mname, p.Lname) as FIO
  	from Person p right join Client c 
    	on c.id_Person = p.id_Person
  	where p.id_Person in 
  	(select w.id_Person
    	from Worker w);