page 70068 "Liste Ajustement Validees"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 70018;
    Editable = false;
    CardPageId = 70066;
    SourceTableView = where(Posted = const(true));
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            repeater("Ajustements")
            {
                field("No."; rec."No.")
                {
                }
                field(Type; rec.Type)
                {
                }
                field("Document Date"; rec."Document Date")
                {
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Editable = false;
                }
                field("Item No."; rec."Item No.")
                {
                    trigger OnValidate()
                    var
                        // item: record Item;
                    begin
                        // item.SetRange("No.", rec."Item No.");
                        // if item.FindFirst() then begin
                        //     rec.Description := item.Description;
                        // end;
                    end;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {

                }
                field("Nombre Cartons"; rec."Nombre Cartons")
                {

                }
                field("Quantité"; rec."Quantité")
                {

                }

            }
        }
    }

    actions
    {

    }
}