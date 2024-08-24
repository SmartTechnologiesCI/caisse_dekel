page 70055 "Ecriture valeur 5802"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 5802;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No.";"Entry No.")
                {
                    ApplicationArea = All;
                    
                }
                field("Item No.";"Item No."){

                }
                field("Posting Date";"Posting Date"){

                }
                field(Type;Type){

                }
                field("Source No.";"Source No."){

                }
                field("Document No.";"Document No."){
                    
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}   