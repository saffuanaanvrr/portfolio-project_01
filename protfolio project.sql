/*SELECT * FROM CovidDeaths$
 where continent is not null
order by 3,4
*/
/*select * from CovidVaccinations$
order by 3,4*/

 
 

/*SELECT location,date,total_cases,total_deaths, (total_deaths/total_cases) as DeathPercentage
FROM CovidDeaths$
where location LIKE '%India%'
ORDER BY 1,2
*/





/*SELECT location,date,total_cases,Population,total_deaths, (total_deaths/Population) as PercentagePopulationInfected
FROM CovidDeaths$
--where location LIKE '%India%'
ORDER BY 1,2
*/



/*SELECT location,Population,max(total_cases) as HighestInfectionCount, max(total_deaths/Population)*100 as PercentagePopulationInfected
FROM CovidDeaths$
--where location LIKE '%India%'
group by location,Population 
order by PercentagePopulationInfected desc*/



-- high deathcount by continent 



/*SELECT location,max(cast(total_deaths as int)) as DeathCount
FROM CovidDeaths$
where continent is  null
--where location LIKE '%India%'
group by location 
order by DeathCount desc
*/


-- by country wise

/*
SELECT location,max(cast(total_deaths as int)) as DeathCount
FROM CovidDeaths$
where continent is not  null
--where location LIKE '%India%'
group by location 
order by DeathCount desc
*/




/* SELECT continent,max(cast(total_deaths as int)) as DeathCount
FROM CovidDeaths$
where continent is not  null
--where location LIKE '%India%'
group by continent
order by DeathCount desc
*/


--GLOBAL NUMBERS

/*Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM CovidDeaths$
where continent is not  null
--where location LIKE '%India%'
--group by continent 
--group by date
order by 1,2
*/

/*Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths$ dea
Join CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
*/


/*
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths$ dea
Join CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

*/

/*
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths$ dea
Join CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
*/




/*
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths$ dea
Join CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 


select * from PercentPopulationVaccinated


*/
