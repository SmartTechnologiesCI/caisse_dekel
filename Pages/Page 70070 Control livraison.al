page 70070 "Controle livraison"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Controle Livraison";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No article"; rec."No article")
                {

                }
                field(dateFilter; dateFilter) { }
            }
        }
        /*      area(Factboxes)
             {

             } */
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
    trigger OnOpenPage()
    var
        myInt: Integer;
        "Sales Invoice Header": Record "Sales Invoice Header";
    begin
        //rec.SetFilter(dateFilter, '>=%1', DMY2Date(20, 4, 2021));
        //"Sales Invoice Header".SetRange("Document Date",dateFilter);
        "Sales Invoice Header".SetRange("Statut Livraison", "Sales Invoice Header"."Statut Livraison"::"Payée Non livré");
        "No article" := "Sales Invoice Header"."No.";

    end;
}