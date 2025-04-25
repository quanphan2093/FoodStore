using FoodStoreAPI.DTO;
using FoodStoreAPI.Models;

namespace FoodStoreAPI.DAO
{
    public class CategoryDAO
    {
        public static List<Category> getCategory()
        {
            List<Category> listCate = new List<Category>();
            try
            {
                listCate = FoodStoreContext.Ins.Categories.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return listCate;
        }
        public static List<CategoryDTO> getCategoryDTO()
        {
            List<CategoryDTO> listCate = new List<CategoryDTO>();
            try
            {
                listCate = FoodStoreContext.Ins.Categories.Select(x => new CategoryDTO
                {
                    CateId = x.CateId,
                    CateName = x.CateName
                }).ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return listCate;
        }
    }
}
