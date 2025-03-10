page 70069 "Prix Categorie"
{
    PageType = ReportProcessingOnly;
    ApplicationArea = All;
    UsageCategory = Administration;




    layout
    {
        area(Content)
        {
            group("Article")
            {

                field("Code"; CategorieArticle.Code)
                {
                    Caption = 'Categorie article';
                    TableRelation = "Item Category".Code;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        itemCategory: Record "Item Category";

                    begin
                        itemCategory.SetRange("Code", CategorieArticle."Code");
                        if itemCategory.FindFirst() then begin
                            description := itemCategory.Description;

                        end;
                    end;
                }

                field(Description; Description)
                {
                    Editable = false;
                }

                field(PrixCategorie; PrixCategorie)
                {
                    Editable = true;
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

    trigger OnOpenPage()
    var
        myInt: Integer;


    begin
        // CategorieArticle.SetRange("Code", CategorieArticle."Code");

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        item: Record Item;
        // salePrice: Record "Sales Price";

    begin
        // if (CloseAction = CloseAction::OK) then begin
        //     if PrixCategorie <= 0 then begin
        //         Error('Le prix ne peut etre vide');
        //     end

        //     else begin
        //         salePrice.Reset();
        //         item.SetRange("Item Category Code", CategorieArticle.Code);
        //         salePrice.SetRange("Item No.", item."No.");
        //         if item.FindFirst() then begin
        //             repeat
        //                 // Changer le prix de l'article
        //                 salePrice.Reset();
        //                 salePrice.SetRange("Sales Type", salePrice."Sales Type"::"All Customers");
        //                 salePrice.SetRange("Item No.", item."No.");
        //                 salePrice.setRange("Minimum Quantity", 0);
        //                 if (salePrice.FindFirst()) then begin

        //                     salePrice."Price Includes VAT" := true;
        //                     salePrice."Unit Price" := PrixCategorie;
        //                     salePrice.Modify();
        //                 end else begin
        //                     salePrice.Reset();

        //                     salePrice."Sales Type" := salePrice."Sales Type"::"All Customers";
        //                     salePrice."Item No." := item."No.";
        //                     salePrice."Minimum Quantity" := 0;
        //                     salePrice."Price Includes VAT" := true;
        //                     salePrice."Unit Price" := PrixCategorie;
        //                     salePrice.Insert();
        //                 end;





















                    /*                   item."Price Includes VAT" := true;
                                      if salePrice."Unit Price" <> '0' then 
                                      begin
                                          salePrice."Unit Price" := PrixCategorie;
                                          salePrice.Modify();
                                      end else 
                                      if salePrice."Unit Price"=0 then 
                                      begin
                                          salePrice."Unit Price" := PrixCategorie;
                                          salePrice.Modify();
                                      end else 
                                      begin
                                          salePrice."Unit Price" := PrixCategorie;
                                          salePrice.Insert();   

                                      end; */

    //                 until item.Next = 0;
    //             end;
    //             Message('Les prix on bien été fixé');

    //         end;
    //     end;
     end;

    var
        myInt: Integer;
        // article: Record Item;
        CategorieArticle: Record "Item Category";
        description: Text[100];
        PrixCategorie: Decimal;
}