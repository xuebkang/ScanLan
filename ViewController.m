//
//  ViewController.m
//  ScanLanDemo
//
//  Created by Kevin--Xue on 2020/7/25.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "ViewController.h"
#import "ScanLAN.h"
#import "Device.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, ScanLANDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *connctedDevices;
@property (nonatomic, strong) ScanLAN *lanScanner;

@end

@implementation ViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"获取局域网内所有IP";
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self startScanningLAN];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.lanScanner stopScan];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(startScanningLAN)];
    self.navigationItem.rightBarButtonItem = refreshBarButton;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

//开始扫描局域网
- (void)startScanningLAN {
    [self.lanScanner stopScan];
    self.lanScanner = [[ScanLAN alloc] initWithDelegate:self];
    self.connctedDevices = [[NSMutableArray alloc] init];
    [self.lanScanner startScan];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 50;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

#pragma mark --UITableDelegateAndDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.connctedDevices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    Device *device = self.connctedDevices[indexPath.row];
    cell.textLabel.text = device.name;
    return cell;
}


#pragma mark LAN Scanner delegate method
- (void)scanLANDidFindNewAdrress:(NSString *)address havingHostName:(NSString *)hostName {
    NSLog(@"found  %@", address);
    Device *device = [[Device alloc] init];
    device.name = hostName;
    device.address = address;
    [self.connctedDevices addObject:device];
    [self.tableView reloadData];
}

- (void)scanLANDidFinishScanning {
    NSLog(@"Scan finished");
    [[[UIAlertView alloc] initWithTitle:@"Scan Finished" message:[NSString stringWithFormat:@"Number of devices connected to the Local Area Network : %ld", self.connctedDevices.count] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
@end
