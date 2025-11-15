page 70088 ligneObjectif
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Ligne Ojectif Commercial";
    Caption = 'Ligne objectif';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No Task";"No Task")
                {
                    ApplicationArea = All;
                    
                }
                field(Description;Description){}
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
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
}