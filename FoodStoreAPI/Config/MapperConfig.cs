using AutoMapper;
using FoodStoreAPI.DAO;
using FoodStoreAPI.Models;

namespace FoodStoreAPI.Config
{
    public class MapperConfig : Profile
    {
        public MapperConfig()
        {
            CreateMap<Account, AccountDAO>().ReverseMap();
        }
    }
}
