page 70091 "Liste Transfert"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 70026;
    Editable = false;
    CardPageId = 70093;
    SourceTableView = where(Posted = const(false));
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            repeater("Transfert")
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

                field("Location CodeDest"; rec."Location CodeDest")
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
        area(Processing)
        {
            action("Liste des ajustements validées")
            {
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostedInventoryPick;
                //  RunObject = page 70068;
                RunPageMode = view;
            }
        }
    }
}