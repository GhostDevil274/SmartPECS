import Foundation

// Định nghĩa các loại thử thách
enum LevelType {
    case findFlashcard(target: PecsCardModel, options: [PecsCardModel])
    case emotion(targetEmotion: String)
}

struct CardLibrary {
    static let allCards: [PecsCardModel] = [
        
        // ======================================================
        // MARK: - HẠNG MỤC 1: NHU CẦU CƠ BẢN & SINH HOẠT (Needs)
        // ======================================================
        
        PecsCardModel(
            id: "eat",
            title: "Ăn",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5il1-aT-HVLhUseZ7vDAYJMJvkaxK2cRpomgC4-c1gw&s=10", // Bé đang ăn cơm
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwfUYG1S1u8OzOtPQzyN6JNd0kAewrn-I48Hme1aOtag&s=10", // Bữa ăn gia đình
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYgjH1IRAuVJ-ybB5vqhcAPPw47-Jsp9mW3h_AX-LuHw&s=10"  // Đĩa thức ăn
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "drink",
            title: "Uống nước",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaDf0VhOszjuvO7eXRLE_I3NcBf1V5A6CpA7GjM_KDIA&s=10", // Rót nước vào ly
                "https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&w=300&q=80", // Cầm ly nước uống
                "https://images.unsplash.com/photo-1523362628745-0c100150b504?auto=format&fit=crop&w=300&q=80"  // Chai nước lọc
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "toilet",
            title: "Đi vệ sinh",
            imageNames: [
                "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=300&q=80", // Bồn cầu sạch sẽ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-h8SOoZPGqixjYKt2Q4WT7uyTLsVgoHD8MjMNHY-I8Q&s=10", // Toàn cảnh phòng tắm
                "https://thanhnien.mediacdn.vn/Uploaded/ngocthanh/2022_01_07/di-ve-sinh1-1364.jpg"  // Giấy vệ sinh
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "sleep",
            title: "Đi ngủ",
            imageNames: [
                "https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?auto=format&fit=crop&w=300&q=80", // Bé đang ngủ ngon
                "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=300&q=80", // Chiếc giường êm ái
                "https://images.unsplash.com/photo-1531353826977-0941b4779a1c?auto=format&fit=crop&w=300&q=80"  // Gối và chăn
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "shower",
            title: "Đi tắm",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_OotbPvc3kzsxRIptkJSrfh8Xzq8ILO42QxgtKLAkdQ&s=10", // Vòi hoa sen đang chảy
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpDAu8R8bkIlUYPTj7Z-6XAtUOw-GMde4PwDGMQfa6MA&s=10", // Bồn tắm có xà phòng
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfMK7jehikoKOjwdwGWXMEtkO6T_6rzmCZaBG-DQIc9Zvr0A5iaPvt9Rs9&s=10"  // Trẻ em chơi đùa trong bồn tắm
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "brush_teeth",
            title: "Đánh răng",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6u318nvEl6ECU0OiFDGHCYoCbLz3f3FPFk1eqpEYViw&s=10", // Bàn chải và kem đánh răng
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG0JDb5X3CDho_kHVsA1JRWQFr_Cxoo6OQ7J9-auewFw&s=10", // Đang đánh răng trước gương
                "https://vcdn1-suckhoe.vnecdn.net/2022/06/04/chai-rang-1316-1654278416.jpg?w=1020&h=0&q=100&dpr=2&fit=crop&s=HD7py7xVZ7BNXi9MVQZXoA"  // Ly nước và bàn chải
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "help",
            title: "Giúp đỡ",
            imageNames: [
                "https://images.unsplash.com/photo-1469571486292-0ba58a3f068b?auto=format&fit=crop&w=300&q=80", // Nắm tay giúp đỡ
                "https://image.ngaynay.vn/w800/Uploaded/2026/znaeng/2021_07_22/giup-do-nguoi-khac-1-0929-8927.jpg", // Chữ Help
                "https://pantado.edu.vn/wp-content/uploads/2020/01/zQDOySfBrigfDztkNPLtU5i6VDO04fTr3zypiflI.jpeg"  // Người lớn giúp trẻ em
            ],
            category: "Needs"
        ),
        
        PecsCardModel(
            id: "wear_clothes",
            title: "Mặc áo quần",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyoa7DyTcwXNztrp22INSkDAfbO8infqwl2-QPI4OSQfUqRf_0lDqK-sxL&s=10", // Quần áo trẻ em gấp gọn
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWXE-K3qegMs7DKnosKZAmvnrQ9-_rKvGk57LfGUkuFw&s=10", // Tủ quần áo
                "https://bizweb.dktcdn.net/thumb/1024x1024/100/428/200/products/z5568592274126-f292cfcd3d42815744c10e23c4b0af7b.jpg?v=1719293831580"  // Bé tự mặc áo
            ],
            category: "Needs"
        ),
        
        // ======================================================
        // MARK: - HẠNG MỤC 2: ĐỒ ĂN, THỨC UỐNG & ĐỒ CHƠI (Food & Play)
        // ======================================================
        
        // --- NHÓM ĐỒ ĂN & THỨC UỐNG ---
        PecsCardModel(
            id: "rice",
            title: "Cơm",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUJjzfDO-K_zhQWHLZc20PJLU7yvruYG0HYQdiT4AnjK3rXJ8DhB7esxLO&s=10", // Bát cơm trắng
                "https://vcdn1-suckhoe.vnecdn.net/2026/04/22/e54359b5c78b4bb19f867928009283-1989-6195-1776833221.jpg?w=1020&h=0&q=100&dpr=2&fit=crop&s=N67L1i23SkUM55wc1UVcVQ", // Cơm và muỗng
                "https://blog.dktcdn.net/files/com-phan-1.jpg"  // Cơm phần
            ],
            category: "Food"
        ),
        
        PecsCardModel(
            id: "milk",
            title: "Uống sữa",
            imageNames: [
                "https://images.unsplash.com/photo-1563636619-e9143da7973b?auto=format&fit=crop&w=300&q=80", // Ly sữa trắng
                "https://images.unsplash.com/photo-1550583724-b2692b85b150?auto=format&fit=crop&w=300&q=80", // Hộp sữa giấy
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJDM60uc6x7WhAc3m58oVt4LUIy6x1IfI6eM5pe2mv3g&s=10"  // Rót sữa vào ly
            ],
            category: "Food"
        ),
        
        PecsCardModel(
            id: "bread",
            title: "Bánh mì",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAHA-nciAzVjLEKhQXwHyvEfpDgNdqhCRzK90tOmeIMg&s=10", // Ổ bánh mì
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6dyCAHf_RjBIR66GJloqY_FXOWgdcPppHA5_RFXTD4w&s=10", // Bánh mì gối cắt lát
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_VmeSGhcabEIcgAB0n0NYOHxB13bPyWglVBKSM1E3Kw&s=10"  // Bánh mì kẹp
            ],
            category: "Food"
        ),
        
        PecsCardModel(
            id: "banana",
            title: "Quả chuối",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDXF2otJSlZ9-eQ24HELijQF6gaxr89yW2-r5408eOw&s=10", // Nải chuối vàng
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq9Qqcxy3YvKs_lujOGgnxLezmxeFF0acmDLW7AIWlAQ&s=10", // Quả chuối bóc vỏ
                "https://img.thuonghieusanpham.vn/img/TAPCHI_THSP/news_dataimages/2023/082023/28/09/in_article/chuoi-3120230828090551.jpg?rt=20230828090551"  // Chuối cắt lát
            ],
            category: "Food"
        ),
        
        PecsCardModel(
            id: "cake",
            title: "Bánh ngọt",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTePXGSpFwLi6qmLZBoOFYeM3735LO9wbxyrMBQfa_5ew&s=10", // Bánh kem
                "https://cdn.tgdd.vn/Files/2021/03/09/1333700/cac-loai-banh-ngot-duoc-yeu-thich-nhat-tai-viet-nam-202103090933169585.jpg", // Bánh cupcake
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRBsMdATc7UGIkZm8KYj-nM9Ch1uti199J9z4ooPbmNDVkTf93xs-Rnwep&s=10"  // Bánh quy
            ],
            category: "Food"
        ),

        // --- NHÓM ĐỒ CHƠI & GIẢI TRÍ ---
        PecsCardModel(
            id: "teddy",
            title: "Gấu bông",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ-FHpXx2Ik7gZZXWKTX92Xo9Z1mmZbA9k6HjRrC-UY9I3rD-G2EWgGfZW&s=10", // Gấu bông nâu
                "https://hoatuoi360.vn/uploads/file/Baiviet2024/gau-bong-mon-qua-pho-bien.jpg", // Gấu bông nhỏ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUU5s5hvBLoOPQWM6qDtwiIVLalJ23Vt_cNDAJwmSJ4w&s=10"  // Thú nhồi bông khác
            ],
            category: "Play"
        ),
        
        PecsCardModel(
            id: "puzzle",
            title: "Xếp hình",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvmwx99d4iG_RO9OnIJTFlTVL5t8gjqn0S3xrC-zgz-w&s=10", // Xếp hình lego
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6GNlU4ft53jQFxUuNficDs5M0kCCyIIu2XRe-WpmZWZqqI2KD9J_IpQfr&s=10", // Khối gỗ xếp hình
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMI7_AIffW5Ul685EmjbXGQJzId9aJt4osM15z5ZR26Q&s=10"  // Mảnh ghép puzzle
            ],
            category: "Play"
        ),
        
        PecsCardModel(
            id: "ball",
            title: "Quả bóng",
            imageNames: [
                "https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1d/Football_Pallo_valmiina-cropped.jpg/250px-Football_Pallo_valmiina-cropped.jpg?utm_source=vi.wikipedia.org&utm_campaign=parser&utm_content=thumbnail", // Quả bóng đá
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT86b-mRgYmAaFCAkGvxX88BX4XHuAwxc4iv_dCYa-iOA&s=10", // Bóng rổ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7oWMzOkUeplC8p-XNzbsSDg-6rnZZajDiEyQFQnEu6GQBV8gwVd5aU6p&s=10"  // Bóng cao su nhiều màu
            ],
            category: "Play"
        ),
        
        PecsCardModel(
            id: "ipad",
            title: "Điện thoại / iPad",
            imageNames: [
                "https://cellphones.com.vn/sforum/wp-content/uploads/2021/09/0028aspHgy1gupry9fib7j61900u0tbc02.jpg", // Bé cầm iPad
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbqW0_9rPVyCqmr4UFwERTCBXqQjns01V3RB8zPdRZyw&s=10", // Điện thoại trên tay
                "https://tiki.vn/blog/wp-content/uploads/2023/11/dien-thoai-gia-re-duoi-1-trieu-thumbnail.jpg"  // Cầm máy tính bảng
            ],
            category: "Play"
        ),
        
        PecsCardModel(
            id: "tv",
            title: "Xem Tivi",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuPBNPit52q5l6JoCOi6BK8Skf6NKEAciDtFhKdvh6Kx20Sze9TQb44dY&s=10", // Màn hình TV lớn
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqhlezrG0bFKCCx-kWEbZawnfhPq70ugnkGLg8ovwR6KMWX1WoeJ9IapY&s=10", // Cầm remote bấm TV
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKkUBLZwms9VKFON4Zvgt2KAjcqEBOTAlZUNNweigCMW5DPmPKPzye49LN&s=10"  // Gia đình xem TV
            ],
            category: "Play"
        ),
        // ======================================================
        // MARK: - HẠNG MỤC 3: ĐỘNG VẬT, PHƯƠNG TIỆN & ĐỒ VẬT
        // ======================================================
        
        // --- NHÓM ĐỘNG VẬT (Animals) ---
        PecsCardModel(
            id: "dog",
            title: "Con chó",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt8qRCzzvlGZxJ6OHFxOEJ36GZrMMXXaD2PoYRzZsYuQ&s=10", // Chó lông vàng
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa9yBGxxe34O5PpK2w47Fcz7KPiPBdxKhTY1MPBekDOQ&s=10", // Chó mõm ngắn
                "https://azpet.b-cdn.net/wp-content/uploads/2021/06/cho-corgi-5.jpg"  // Chó Husky
            ],
            category: "Animal"
        ),
        
        PecsCardModel(
            id: "cat",
            title: "Con mèo",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3QGQB2pwrxLLihnu8CzvkXDGxzlN6f1-8Hmr6d8J2hA&s=10", // Mèo vàng
                "https://xuonggomsuviet.vn/wp-content/uploads/2019/12/y-nghia-hinh-tuong-con-meo-trong-van-hoa-dan-gian-5.jpg", // Mèo nhìn thẳng
                "https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/avatar-anh-meo-cute-6.jpg"  // Mèo nằm lười
            ],
            category: "Animal"
        ),
        
        PecsCardModel(
            id: "bird",
            title: "Con chim",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKhPvVKqOxO8gKWTMvLxDAAXHCFWrmgfG4mKqhzoBXhA&s=10", // Chim sẻ
                "https://i.ex-cdn.com/nongnghiepmoitruong.vn/files/bao_in/2022/07/04/anh-3-con-chim-se-1722_20220615_914-155512.jpeg", // Chim vẹt
                "https://i1.sndcdn.com/artworks-000159637947-rdwamq-t500x500.jpg"  // Chim đậu trên cành
            ],
            category: "Animal"
        ),

        // --- NHÓM PHƯƠNG TIỆN (Vehicles) ---
        PecsCardModel(
            id: "car",
            title: "Xe ô tô",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScHJSoAB4EBvcOwPK_OLukNuouOxTaYsU0BsKjCfXzQTJyH2LD1lQidZvh&s=10", // Ô tô con màu đỏ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOcoq3FlJiCLyeP4CAjTy9BBG7VPrl2nUT72RgM2-YaA&s=10", // Ô tô đi trên đường
                "https://phugiaauto.vn/wp-content/uploads/2023/09/top_14_hang_xe_o_to_hang_sang_ua_chuong_nhat_viet_nam_1.jpg"  // Xe thể thao
            ],
            category: "Vehicle"
        ),
        
        PecsCardModel(
            id: "bus",
            title: "Xe buýt",
            imageNames: [
                "https://cdn-media.sforum.vn/storage/app/media/thanhhuyen/b%E1%BA%A3n%20%C4%91%E1%BB%93%20xe%20bus%20tp%20h%E1%BB%93%20ch%C3%AD%20minh/ban-do-xe-bus-tp-ho-chi-minh-thumb.jpg", // Xe buýt vàng
                "https://upload.wikimedia.org/wikipedia/commons/f/f8/Tr%E1%BA%A1m_xe_bu%C3%BDt_%C4%90H_T%C3%B4n_%C4%90%E1%BB%A9c_Th%E1%BA%AFng.jpg?utm_source=vi.wikipedia.org&utm_campaign=index&utm_content=original", // Xe buýt trường học
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnEqq5xlrz1u3Xw4QKPVhK5yOls8HZuOKbjIMRuvQE6A&s=10"  // Xe buýt công cộng
            ],
            category: "Vehicle"
        ),
        
        PecsCardModel(
            id: "bicycle",
            title: "Xe đạp",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUSADVjUXAhpwkrvVpzruAjot7nRGwTKSgfhigX291_g&s=10", // Xe đạp ở bãi cỏ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4rq5D7r6064kIugNn0mHTrA0AzEMCFxHRIRnRfNvNAQ&s=10", // Xe đạp trẻ em
                "https://bizweb.dktcdn.net/thumb/1024x1024/100/412/747/files/52.jpg?v=1694243074546"  // Đi xe đạp
            ],
            category: "Vehicle"
        ),

        // --- NHÓM ĐỒ VẬT QUEN THUỘC (Objects) ---
        PecsCardModel(
            id: "shoes",
            title: "Đôi giày",
            imageNames: [
                "https://agiay.vn/wp-content/uploads/2022/09/giay-the-thao-nu-ag0155-13.jpg", // Giày thể thao đỏ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKiruVvZD1fSgImXCmU5ZHl13RHXeeP91gK_3vS4wTzXzP9a2RkDifods&s=10", // Giày buộc dây
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcKTwmhfz2aw_WRSBuzdiEG6JS3qwG4RXVY_ktqPf0uQ&s=10"  // Giày búp bê / bata
            ],
            category: "Object"
        ),
        
        PecsCardModel(
            id: "backpack",
            title: "Cặp sách",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgdmDdi4rdWTmdSEdlwNbxnWmgd69DcURWWyalYd3Ccw&s=10", // Balo học sinh
                "https://bizweb.dktcdn.net/thumb/grande/100/299/021/products/cap-da-nang-mr-vui-450-15.jpg?v=1780286552027", // Balo da
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2xtPba5_Vp5v-Q45FRo8t0IECi1GziqhnpebuB-1g9g&s=10"  // Balo nhiều màu
            ],
            category: "Object"
        ),
        
        PecsCardModel(
            id: "book",
            title: "Quyển sách",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoniHTogKsAHx25G__qI18UEzXksq6uHSWAFGzmCxECg&s=10", // Sách mở ra
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGUYwJLaz_z5c6glC297H3ylX1qVLIC1aAAP7Jy8hrQg&s=10", // Chồng sách
                "https://static.ybox.vn/2022/6/3/1655290314870-2021_05_27______d326ed021ef9c5f7dbe5ad589bf9d036.jpeg"  // Đọc sách
            ],
            category: "Object"
        ),
        // ======================================================
        // MARK: - HẠNG MỤC 4: CẢM GIÁC & CẢM XÚC (Sensory & Feelings)
        // ======================================================
        
        // --- NHÓM CẢM GIÁC CƠ THỂ (Sensory) ---
        PecsCardModel(
            id: "hot",
            title: "Trời nóng",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvdjLsuu5m5xBOMSd1KGIOV9tkHpUj0MfJVjVVjZ4MbDc7vhyjzd3UKltD&s=10", // Mặt trời gắt
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEYusR3OUwuqi_tlAO5iU5Gv1ydT7zSvr1GshOatHXcH1IMKI1JMHiqVc&s=10", // Uống nước vì nóng
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9vQR7uqTt3EvRfM00_x-N9iPU4mlncXFA4RuIiUCRhN28XOhvIBFEv_Y&s=10"  // Quạt máy
            ],
            category: "Sensory"
        ),
        
        PecsCardModel(
            id: "cold",
            title: "Trời lạnh",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoYCliunCGlTYy4HF5-JoppNYoZIzRVDaf8C_irOhPcg&s=10", // Phong cảnh tuyết
                "https://pethouse.com.vn/wp-content/uploads/2023/12/troi-lanh.jpg", // Mặc áo ấm
                "https://media-cdn-v2.laodong.vn/storage/newsportal/2022/11/30/1122587/12.jpg?w=800&h=496&crop=auto&scale=both"  // Đeo găng tay mùa đông
            ],
            category: "Sensory"
        ),
        
        PecsCardModel(
            id: "noisy",
            title: "Ồn ào quá",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_NZqXrzgPE_cHGYTWrpJ3aDM-RFI2qSXmzIAacb_brw&s=10", // Bịt tai
                "https://image3.luatvietnam.vn/uploaded/images/original/2025/12/18/cach-phan-anh-khi-hang-xom-hat-karaoke-on-ao_1812155832.jpg", // Loa phóng thanh
                "https://cdn-i.vtcnews.vn/files/f2/2014/08/19/o-noi-qua-on-ao-ban-bi-ton-tho-0.jpg"  // Đám đông ồn ào
            ],
            category: "Sensory"
        ),
        
        PecsCardModel(
            id: "hurt",
            title: "Bị đau",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8vxSLtlqAZw8yLJRRM_RuqEs2HP3TSTniYrIBkXGfbD_ID45VLXlT09c&s=10", // Băng dán cá nhân urgo
                "https://thanhnien.mediacdn.vn/Uploaded/ngocquy/2022_01_11/1-dau-co-shutterstock-2195.jpg", // Xoa đầu vì đau
                "https://hapacol.vn/wp-content/uploads/2023/09/dau-co-chan-1.jpg"  // Ngã xước chân
            ],
            category: "Sensory"
        ),
        
        // --- NHÓM CẢM XÚC (Feelings) ---
        PecsCardModel(
            id: "happy",
            title: "Vui vẻ",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNvg7zfFGQvhu-eYYyplValwC-KH5OMQcY9aOv_WoNnHz7UNJafWfT8dE&s=10", // Trẻ em cười tươi
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3_AXDILjilNecSc8IPw2axxJJCzFnPKfKwHHciZjbSkcBaLMPQyLu1DI&s=10", // Nụ cười hạnh phúc
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn9KcSwEeaZGQEjrhYgXswtc0XvtbJXKnYJv5cYS3OVtJpN-BZc9RMIlJj&s=10"  // Nhảy múa vui vẻ
            ],
            category: "Feelings"
        ),
        
        PecsCardModel(
            id: "sad",
            title: "Đang buồn",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTET-Qrl59jm_sO3lchAYpj9f4cRsgYz-UAo2gMMMmH7g&s=10", // Khuôn mặt buồn
                "https://media.istockphoto.com/id/457097653/vi/anh/khu%C3%B4n-m%E1%BA%B7t-bu%E1%BB%93n-b%C3%A3.jpg?s=170667a&w=0&k=20&c=4E4wx77DEr9BRpcZtXRnJbW0dNQX3SGEaZkMYJwRJ6k=", // Bé khóc
                "https://mobileapp-assets.aeonmall-vietnam.com/website/16/blogs/December2024/gb7ffPIC8AKArz9Eo4Ct.jpg"  // Ngồi một mình gục đầu
            ],
            category: "Feelings"
        ),
        
        PecsCardModel(
            id: "angry",
            title: "Tức giận",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV70FM9f-g2W_jmbnOCaSOHIVqDOJ-iNf-_CaWFdCmXg&s=10", // Nhíu mày giận dữ
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHYnlkM14vLrYcRMCiV-KiJguQBg95kORrPthsw5Ef-A&s=10", // Khoanh tay khó chịu
                "https://vcdn1-giadinh.vnecdn.net/2013/07/20/angry-kid2-1374286598.jpg?w=1020&h=0&q=100&dpr=2&fit=crop&s=fkAEB643HekS0H4kWb1tDQ"  // Hét lên
            ],
            category: "Feelings"
        ),
        // ======================================================
        // MARK: - HẠNG MỤC 5: HÀNH ĐỘNG (Actions)
        // ======================================================
        
        PecsCardModel(
            id: "run",
            title: "Chạy bộ",
            imageNames: [
                "https://cdn2.tuoitre.vn/tto/i/s626/2016/08/29/chay-bo-1472468332.jpg", // Bé đang chạy
                "https://timve365.vn/uploads/f_65eed5100d1ae10fc9f88051/20191101-ghl-9-rc-1-typ-v-5-xllwdrfw-dz-vr-20242201711.jpg", // Chạy trên sân cỏ
                "https://pos.nvncdn.com/be3294-43017/art/20231123_d96uc7NV.jpeg"  // Chạy thể dục
            ],
            category: "Action"
        ),
        
        PecsCardModel(
            id: "walk",
            title: "Đi bộ",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvVqtzndaciWx7fJj9qFTrpnmRYHeVHhdvJUJHkcKBL5GINYsH0vxFhhKS&s=10", // Nắm tay đi dạo
                "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2024/8/28/photo-1724840072492-17248400725701545135551.jpeg", // Đi dạo trong công viên
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy6oPARhJmsP0vSpbb_UYUEbAAFavttm1M5LJtn59a6g&s=10"  // Bước chân đi
            ],
            category: "Action"
        ),
        
        PecsCardModel(
            id: "sit",
            title: "Ngồi xuống",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI0vqtZ5qabVUbE3L-NZImgzfeicoPdyKMCoQ94fBfSw&s=10", // Ngồi ngoan trên ghế
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKbiBChfPT4tku6Qh5UQbeb2WOJBJeILIcMKV_K71bu33kBk6GbgE93a_f&s=10", // Ngồi bệt trên sàn
                "https://cdn.tgdd.vn/Files/2020/07/02/1267031/khi-nao-thi-nen-tap-ngoi-cho-be-10-cach-tap-ngoi-dung-chuan-de-khong-anh-huong-cot-song-202007020837230837.jpg"  // Ngồi ở băng ghế
            ],
            category: "Action"
        ),
        
        PecsCardModel(
            id: "swim",
            title: "Bơi lội",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAAPSrNXfRDJ8nSF6cXIISxNPUkZH7_bCWgBUkQwVy5A&s=10", // Trẻ em bơi với phao
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9xgxY7fP8Z7MCz18uC44Quo1aNIVIq9esKw0RUiufbWRIjlAXulvKnvg&s=10", // Hồ bơi xanh
                "https://yeuboiloi.com/wp-content/uploads/2022/05/kid_swimming_lesson_4.jpg"  // Đang bơi
            ],
            category: "Action"
        ),
        
        // ======================================================
        // MARK: - HẠNG MỤC 6: GIAO TIẾP XÃ HỘI (Social & Communication)
        // ======================================================
        
        PecsCardModel(
            id: "hello",
            title: "Xin chào",
            imageNames: [
                "https://homevina.vn/pic/News/images/cach-chao-hoi-cua-nguoi-han-quoc.jpg", // Vẫy tay chào
                "https://png.pngtree.com/png-clipart/20210310/original/pngtree-hand-drawn-children-say-hello-and-say-hello-png-image_5937126.jpg", // Hai bạn nhỏ vẫy tay
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-CRakL_DHLDTK6U6nukl382f0_1FSkINChCAhjOuEIg&s=10"  // Tươi cười vẫy tay
            ],
            category: "Social"
        ),
        
        PecsCardModel(
            id: "thanks",
            title: "Cảm ơn",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPRPILW3Yh2H0pkEZJoYj98Qb6680t-K5xi1fyiG_tgg&s=10", // Tặng quà
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT53BR6zV-g85pR07wplUw4v4_zwQuWn4RXITKN7RuLKg&s=10", // Cúi đầu / ôm cảm ơn
                "https://www.shutterstock.com/shutterstock/photos/675029053/display_1500/stock-vector-man-in-actions-thank-you-action-675029053.jpg"  // Cười tươi nhận đồ
            ],
            category: "Social"
        ),
        
        PecsCardModel(
            id: "wait",
            title: "Đợi một chút",
            imageNames: [
                "https://thumbs.dreamstime.com/b/wait-sec-hold-perplexed-displeased-angry-redhead-serious-looking-girl-raising-palm-stop-prohibition-gesture-frowning-forbid-152490531.jpg", // Đồng hồ / Thời gian
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJsjtkzPiabbrbiNX15YFg48kK38fj1vAkhmwsJiEDnw&s=10", // Giơ tay ra hiệu dừng/đợi
                "https://asajikan.jp/wp-content/uploads/2021/06/319622_s-600x450.jpg"  // Đứng xếp hàng
            ],
            category: "Social"
        ),
        
        PecsCardModel(
            id: "goodjob",
            title: "Làm tốt lắm",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSty5yu-HGLw3MN1o_PJi9UsuY0muCfA9FEwdwcWg2fD8JLrBsVI0EFdxO8&s=10", // Giơ ngón cái (Thumbs up)
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRosExOaTgV1mTxVD-mdkNO2g-uo9v2I08k-2zCOPOyCdQK94sfqE8mQLA&s=10", // Đập tay (High five)
                "https://media.licdn.com/dms/image/v2/C4E12AQE1xNOizjgYtQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1520114336569?e=2147483647&v=beta&t=aHEZFAsc3O6jnmhjqyZ9YRSNGEpBrmndm9oP0EV5tP4"  // Vỗ tay khen ngợi
            ],
            category: "Social"
        ),
        
        // ======================================================
        // MARK: - HẠNG MỤC 7: NƠI CHỐN (Places)
        // ======================================================
        
        PecsCardModel(
            id: "home",
            title: "Nhà",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj7aCxdkYI44hoBuTqbps9RoUV_z2g1BiI-5QiEbROR_k8E6be2z7Y3iOc&s=10", // Ngôi nhà nhìn từ ngoài
                "https://vinhtuong.com/sites/default/files/inline-images/phong-khach-dep-100.jpg", // Phòng khách
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfvyZO11h3v4DhA0lbve46WVQ1e3eb8OpR4m1G4VPlls-X56bQVkJfwBI&s=10"  // Cửa nhà
            ],
            category: "Place"
        ),
        
        PecsCardModel(
            id: "school",
            title: "Trường học/Lớp học",
            imageNames: [
                "https://images2.thanhnien.vn/528068263637045248/2025/4/28/hinh-nhien-1745824159381198462185.jpg", // Lớp học có bàn ghế
                "https://media-cdn-v2.laodong.vn/storage/newsportal/2026/11/2/1793698/Giao-Vien-17.jpg", // Sân trường
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ99lnglsRiPt-QL0ML9XwqkSBNvQjfFWtGi8q0Zw_FC7qFgSuxeQVfbeGJ&s=10"  // Trẻ em đang học
            ],
            category: "Place"
        ),
        
        PecsCardModel(
            id: "supermarket",
            title: "Siêu thị",
            imageNames: [
                "https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/11/25/1120654/Khuyen-Mai2.jpg", // Xe đẩy siêu thị
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVJsmSVGWwtqpJuWb5cOjrpTQvsQFwKkcGcgniBW8CQZgTubw2-UEPWEo4&s=10", // Các kệ hàng hóa
                "https://www.aeon.com.vn/wp-content/uploads/2024/06/cap-nhat-gio-mo-cua-cua-sieu-thi-aeon.jpg"  // Gian hàng rau củ
            ],
            category: "Place"
        ),
        
        PecsCardModel(
            id: "playground",
            title: "Khu vui chơi",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIuH-cv7zDpeJpmHP7dT9F76m7UZsj3AlM8T5vwaescf-Q2ClT2kx3iZGx&s=10", // Cầu trượt ngoài trời
                "https://static.vinwonders.com/production/khu-vui-choi-quan-7-1.jpg", // Bập bênh / Xích đu
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0eSjqzHv-xSyjLsfCe86UU75H4knjRCFPpLgAMnsPtj9nXd60ENZn0xo&s=10"  // Nhà bóng
            ],
            category: "Place"
        ),
        
        PecsCardModel(
            id: "park",
            title: "Công viên",
            imageNames: [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSMKMOwSgC1CC7G2nzr3KRbnLDwRLnF-_lNIZb6vXbvI4Ki260d9MiA0QF&s=10",
                "https://go2joy.s3.ap-southeast-1.amazonaws.com/blog/wp-content/uploads/2022/02/27162946/cong-vien-central-park.jpg",
                "https://media.vneconomy.vn/images/upload/2024/05/16/cong-vien.jpg"
            ],
            category: "Place")
    ]
}
