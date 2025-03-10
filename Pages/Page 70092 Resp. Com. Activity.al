page 70092 "Respo. Comm. Activities"
{
    // PageType = CardPart;
    // SourceTable = "Commerciale RC";

    // layout
    // {
    //     area(Content)
    //     {
    //         cuegroup("Activite")
    //         {
    //             field("Article en stock"; rec."Article en stock")
    //             {
    //                 trigger OnDrillDown()
    //                 var
    //                     Item: Record Item;
    //                 begin
    //                     Item.Reset();
    //                     Item.SetFilter(Inventory, '>0');
    //                     if Item.FindFirst() then begin
    //                         // Page.run(50018, Item);
    //                     end;
    //                 end;
    //             }
    //         }
    //     }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    // var
    //     myInt: Integer;


    // trigger OnOpenPage()
    // var
    //     myInt: Integer;
    // begin
    //     if NOT rec.GET then
    //         rec.Insert();
    //     CurrPage.Update();
    // end;
