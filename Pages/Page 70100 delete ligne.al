page 70100 "Delete list"
{
    PageType = List;
    //ApplicationArea = All;
   // UsageCategory = Administration;
    SourceTable = "Ligne Ojectif Commercial";
    Editable =false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Details)
            {
                field("No Task";rec."No Task"){

                }
                field(TypeLigne;TypeLigne){}
                field("Date debut";"Date debut"){}
                
                field(Description;Description){}
                
                field(Prime;Prime){}
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
        
        }
    }
}